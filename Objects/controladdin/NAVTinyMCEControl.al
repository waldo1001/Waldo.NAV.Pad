controladdin NAVTinyMCEControl {
    Scripts = 'NAVTinyMCEControl\Scripts\script.js';
    StyleSheets = ;
    StartupScript = 'NAVTinyMCEControl\Scripts\startup.js';

    RequestedHeight = 500;
    RequestedWidth = 500;
    VerticalStretch = true;
    HorizontalStretch = true;

    procedure SetHTML(HTML: Text);
    procedure SetColor(Color : Text);
    
    event ControlAddInReady();
    event GetHTMLReady();
    event GetTextReady();

}