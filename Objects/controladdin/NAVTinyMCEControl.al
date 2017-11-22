controladdin NAVTinyMCEControl {
    Scripts = 'NAVTinyMCEControl\Scripts\script.js',
        'http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.9.1.min.js',
        'http://cdn.tinymce.com/4/tinymce.min.js';
    StyleSheets = ;
    StartupScript = 'NAVTinyMCEControl\Scripts\startup.js';

    RequestedHeight = 700;
    RequestedWidth = 700;
    MinimumHeight = 600;
    MinimumWidth = 600;
    VerticalStretch = true;
    HorizontalStretch = true;

    procedure SetHTML(HTML: Text);
    procedure SetColor(Color : Text);
    procedure GetText();
    Procedure GetHTML();
    
    event ControlAddInReady();
    event GetHTMLReady(value: Text);
    event GetTextReady(value: Text);
    event TextHasChanged();

}