/* codeunit 82120 "WaldoNAVPad Test"
{
  Subtype = Test;

  trigger OnRun();
  begin
  end;

  [Test]
  [HandlerFunctions('DialogHandlerChangeToWaldo')]
  procedure TestShowDialogChange();
  var
    MyText : Text;
    WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";
  begin
    MyText := 'TestText';

    WaldoNAVPadTextClass.Initialize(MyText,100);
    WaldoNAVPadTextClass.LoadTextFromDialog(TRUE,FALSE);

    MyText := WaldoNAVPadTextClass.GetText;

    IF MyText <> 'waldo' THEN ERROR('Text Should have changed to waldo');
  end;

  [Test]
  [HandlerFunctions('DialogHandlerCancel')]
  procedure TestShowDialogCancel();
  var
    WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";
    MyText : Text;
  begin
    MyText := 'TestText';

    WaldoNAVPadTextClass.Initialize(MyText,100);
    WaldoNAVPadTextClass.LoadTextFromDialog(TRUE,FALSE);

    MyText := WaldoNAVPadTextClass.GetText;

    IF MyText <> 'TestText' THEN ERROR('Text should not have changed!');
  end;

  [ModalPageHandler]
  procedure DialogHandlerChangeToWaldo(var WaldoNAVPad : TestPage "WaldoNavPad Blobstore");
  begin
    WaldoNAVPad.FullText.VALUE := 'waldo';
    WaldoNAVPad.OK.INVOKE;
  end;

  [ModalPageHandler]
  procedure DialogHandlerCancel(var WaldoNAVPad : TestPage "WaldoNavPad Blobstore");
  var
    Response : Action;
  begin
    WaldoNAVPad.FullText.VALUE := 'waldo';
    WaldoNAVPad.Cancel.INVOKE;
  end;
}

 */