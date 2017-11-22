page 82101 "WaldoNAVPad HTML"
{
  Caption = 'waldoNAVPad';
  PageType = Card;

  layout
  {
    area(content)
    {
      usercontrol(WaldoNAVPad; NAVTinyMCEControl)
      {
        ApplicationArea=All;
        Visible=true;

        trigger ControlAddInReady();
        begin
          ControlAddInReady := TRUE;

          InitializeContent;
        end;

        trigger GetHTMLReady(value: Text);
        begin
          FullHTML := value;
          //TextHasChanged := FALSE;
          HTMLSaved := TRUE;

          CloseIfAllSaved;
        end;

        trigger GetTextReady(value: Text);
        begin
          FullText := value;
          //TextHasChanged := FALSE;
          TextSaved := TRUE;

          CloseIfAllSaved;
        end;

        trigger TextHasChanged();
        begin
          TextHasChanged := true;
        end;
      }
      
    }
  }

  actions
  {
    area(processing)
    {
      action(Save)
      {
        Image = Save;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;

        trigger OnAction();
        begin
          ActionSave;
        end;
      }
      action("Save & Close")
      {
        Image = Save;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;

        trigger OnAction();
        begin
          ActionSaveAndClose;
        end;
      }
      action(Cancel)
      {
        Image = Delete;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;

        trigger OnAction();
        begin
          ActionCancel;
        end;
      }
      action(Blobs)
      {
        RunObject = Page "WNP Blobs";
      }
      action(Texts)
      {
        RunObject = Page "WNP Texts";
      }
    }
  }

/*   trigger OnQueryClosePage(CloseAction : Action) : Boolean;
  begin
    IF TextHasChanged THEN
      EXIT(CONFIRM('Warning, there is unsaved text .. do you really want to close?',FALSE));
  end; */

  var
    ControlAddInReady : Boolean;
    TextHasChanged : Boolean;
    FullText : Text;
    FullHTML : Text;
    WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";
    HTMLSaved : Boolean;
    TextSaved : Boolean;
    DialogResultOK : Boolean;
    CloseWhenSaved : Boolean;

  procedure SetText(var Value : Text;var HTML : Text);
  begin
    FullText := Value;
    FullHTML := HTML;
  end;

  procedure GetLastSavedText() : Text;
  begin
    EXIT(FullText);
  end;

  procedure GetLastSavedHTML() : Text;
  begin

    EXIT(FullHTML);
  end;

  local procedure ActionSave();
  begin
    CurrPage.WaldoNAVPad.GetText;
    CurrPage.WaldoNAVPad.GetHTML;
    TextSaved := FALSE;
    HTMLSaved := FALSE;
    CloseWhenSaved := FALSE;
  end;

  local procedure ActionSaveAndClose();
  begin
    TextSaved := FALSE;
    HTMLSaved := FALSE;
    CloseWhenSaved := TRUE;
    CurrPage.WaldoNAVPad.GetText;
    CurrPage.WaldoNAVPad.GetHTML;
  end;

  local procedure ActionCancel();
  begin
    DialogResultOK := FALSE;
    TextHasChanged := FALSE;
    CurrPage.CLOSE;
  end;

  local procedure InitializeContent();
  begin
    IF NOT ControlAddInReady THEN EXIT;

    CurrPage.WaldoNAVPad.SetHTML(FullHTML);
    TextHasChanged := FALSE;
  end;

  local procedure CloseIfAllSaved();
  begin
    IF HTMLSaved AND TextSaved THEN BEGIN
      TextHasChanged := FALSE;

      DialogResultOK := TRUE;

      IF CloseWhenSaved THEN
        CurrPage.CLOSE;
    END;
  end;

  procedure GetDialogResultOK() : Boolean;
  begin
    EXIT(DialogResultOK);
  end;
}

