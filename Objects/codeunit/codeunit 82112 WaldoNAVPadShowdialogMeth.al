codeunit 82112 "WaldoNAVPad Showdialog Meth"
{
  trigger OnRun();
  begin
  end;

  procedure ShowDialog(var Text : Text;var HTML : Text;var DialogResultTrue : Boolean;Editable : Boolean;UseHTMLEditor : Boolean);
  var
    Handled : Boolean;
  begin
    OnBeforeShowDialog(Text,HTML,Editable,UseHTMLEditor,Handled);
    DoShowDialog(Text,HTML,DialogResultTrue,Editable,UseHTMLEditor,Handled);
    OnAfterShowDialog(Text,HTML,Editable,UseHTMLEditor);
  end;

  local procedure DoShowDialog(var Text : Text;var HTML : Text;var DialogResultTrue : Boolean;Editable : Boolean;UseHTMLEditor : Boolean;var Handled : Boolean);
  begin
    if Handled then
      exit;

    if UseHTMLEditor then
      ShowTextOnPageHTML(Text,HTML,DialogResultTrue,Editable)
    else
      ShowTextOnPage(Text,HTML,DialogResultTrue,Editable);
  end;

  local procedure ShowTextOnPage(var Text : Text;var HTML : Text;var DialogResultTrue : Boolean;Editable : Boolean);
  var
    WaldoNAVPad : Page WaldoNAVPad;
  begin
    WaldoNAVPad.SetText(Text);
    WaldoNAVPad.LOOKUPMODE := true;
    WaldoNAVPad.EDITABLE := Editable;

    if WaldoNAVPad.RUNMODAL = ACTION::LookupOK then begin
      Text := WaldoNAVPad.GetText;
      HTML := Text;

      DialogResultTrue := true;
    end;
  end;

  local procedure ShowTextOnPageHTML(var Text : Text;var HTML : Text;var DialogResultTrue : Boolean;Editable : Boolean);
  var
    WaldoNAVPadHTML : Page "WaldoNAVPad HTML";
  begin
    WaldoNAVPadHTML.SetText(Text,HTML);
    WaldoNAVPadHTML.LOOKUPMODE := false;
    WaldoNAVPadHTML.EDITABLE := Editable;

    WaldoNAVPadHTML.RUNMODAL;
    if WaldoNAVPadHTML.GetDialogResultOK then begin
      Text := WaldoNAVPadHTML.GetLastSavedText;
      HTML := WaldoNAVPadHTML.GetLastSavedHTML;

      DialogResultTrue := true;
    end;
  end;

  [IntegrationEvent(TRUE, false)]
  local procedure OnBeforeShowDialog(var Text : Text;var HTML : Text;Editable : Boolean;UseHTMLEditor : Boolean;var Handled : Boolean);
  begin
  end;

  [IntegrationEvent(TRUE, false)]
  local procedure OnAfterShowDialog(var Text : Text;var HTML : Text;Editable : Boolean;UseHTMLEditor : Boolean);
  begin
  end;
}

