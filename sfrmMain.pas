unit sfrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, REST.Types, Vcl.ExtCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, json, Data.Cloud.CloudAPI, Data.Cloud.AzureAPI,
  Vcl.ExtDlgs, Vcl.Imaging.jpeg, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

type
  TfrmMain = class(TForm)
    btnSearch: TButton;
    memResponse: TMemo;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    edAPIURL: TLabeledEdit;
    Panel1: TPanel;
    edSubKey: TLabeledEdit;
    edImgPath: TLabeledEdit;
    btnBrowse: TButton;
    dlgOpenImage: TOpenDialog;
    imgSource: TImage;
    scrlbxImages: TScrollBox;
    http: TIdHTTP;
    procedure btnSearchClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
  private
    strImgPath: string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnBrowseClick(Sender: TObject);
var
   Picture: TPicture;
begin
  if not dlgOpenImage.Execute then
    exit;
  strImgPath := dlgOpenImage.FileName;
  btnSearch.Enabled := strImgPath <> '';

  Picture := TPicture.Create;
  Picture.LoadFromFile(strImgPath);
  imgSource.Picture := Picture;
  edImgPath.Text := strImgPath;
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
var
  lparam : Trestrequestparameter;
  imgProcessed: bool;
  jsonObj: TJSONObject;
  jsonTags, jsonActions, jsonValue: TJSONArray;
  MS: TMemoryStream;
  Picture: TPicture;
  I, x, y: integer;
  image: TImage;
begin
  for i:=0 to ComponentCount-1 do
    if (Components[i] is TImage) then
      if (Components[i] as TImage).Parent=scrlbxImages then
        freeandnil(Components[i]);

  memResponse.Lines.Clear;
  RESTClient.BaseURL := edAPIURL.Text;
  RESTRequest.Method:=rmpost;
  imgProcessed := false;
  try
    RESTRequest.Params.Clear;
    RESTResponse.RootElement := '';
    lparam := RESTRequest.Params.AddItem;
    lparam.name := 'Ocp-Apim-Subscription-Key';
    lparam.Value := edSubKey.Text;
    lparam.ContentType := ctNone;
    lparam.Kind := pkHTTPHEADER;
    //This one is Important otherwise the '==' will get url encoded
    lparam.Options := [poDoNotEncode];

    lparam := RESTRequest.Params.AddItem;
    lparam.name := 'image';
    lparam.Value := strImgPath;
    lparam.ContentType := ctIMAGE_JPEG;
    lparam.Kind := pkFile;
    lparam.Options := [poDoNotEncode];
    RESTRequest.Execute;

    if not RESTResponse.Status.Success then
      showmessage(RESTResponse.StatusText + ' ' +
        inttostr(RESTResponse.StatusCode))
    else
    begin
      memResponse.Lines.Add(RESTResponse.JSONText);
      jsonObj := RESTResponse.JSONValue as TJSONObject;
      jsonTags := jsonObj.Values['tags'] as TJSONArray;
      for I := 0 to jsonTags.Count - 1 do
      begin
        jsonObj := jsonTags.Items[I] as TJSONObject;
        jsonActions := jsonObj.Values['actions'] as TJSONArray;
        for x := 0 to jsonActions.Count - 1 do
        begin
          jsonObj := jsonActions.Items[x] as TJSONObject;
          if jsonObj.Values['actionType'].Value = 'PagesIncluding' then
          begin
            jsonValue := (jsonObj.Values['data'] as TJSONObject).Values['value'] as TJSONArray;
            for y := 0 to jsonValue.Count - 1 do
            begin
              if y> 10 then
                Break;
              jsonObj := jsonValue.Items[y] as TJSONObject;

              MS := TMemoryStream.Create;
              http.Get(StringReplace(jsonObj.Values['thumbnailUrl'].Value, 'https', 'http',[rfReplaceAll, rfIgnoreCase]), MS);
              MS.Position := 0;
              Picture := TPicture.Create;
              Picture.LoadFromStream(MS);
              image := TImage.Create(self);
              image.Parent := scrlbxImages;
              image.Align := alTop;
              image.Height := 180;
              image.Picture := Picture;
              image.Center := True;
              image.Proportional := true;
              MS.Free;
            end;
          end;
        end;
      end;
    end;

  finally
  end;
end;

end.
