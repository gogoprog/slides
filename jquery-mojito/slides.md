# jQuery usage in Mojito

---
# jQuery usage in Mojito

## Summary

 * jQuery features overview
    * Selectors
    * Useful methods
    * Events
    * jQuery UI
    * Ajax
 * Usage in Mojito webserver
    * The Good, the Bad and the Ugly
    * Example
    * Conclusion
 * Extra

---
# Main jQuery features
## Selectors

### Main handled expressions

<style type="text/css">
table.myTable { border-collapse:collapse; margin-left:auto; margin-right:auto;}
table.myTable td, table.myTable th { border:1px solid black;padding:5px; }
</style>

<table class="myTable">
    <tr>
        <td><b>Expression</b></td>
        <td><b>Returned value(s)</b></td>
    </tr>
    <tr>
        <td>tag</td>
        <td>All elements with specified tag</td>
    </tr>
    <tr>
        <td>#id</td>
        <td>One element with specified id</td>
    </tr>
    <tr>
        <td>.class</td>
        <td>All elements with specified class</td>
    </tr>
    <tr>
        <td>elem[attr="val"]</td>
        <td>All elements 'elem' that contains the 'attr' attribute with specified value</td>
    </tr>
    <tr>
        <td>tag1 tag2</td>
        <td>All elements 'tag2' that are inside a 'tag1'</td>
    </tr>
    <tr>
        <td>tag1 > tag2</td>
        <td>All elements 'tag2' that are directly inside a 'tag1'</td>
    </tr>
    <tr>
        <td>tag1 + tag2</td>
        <td>All elements 'tag2' that come directly after a 'tag2'</td>
    </tr>
    <tr>
        <td>tag1 ~ tag2</td>
        <td>All elements 'tag2' that come after a 'tag2'</td>
    </tr>
    <tr>
        <td>:parent</td>
        <td>All elements that have children</td>
    </tr>
    <tr>
        <td>:contains(text)</td>
        <td>All elements that contains 'text'</td>
    </tr>
    <tr>
        <td>:has( xxx )</td>
        <td>All elements that contains 'xxx'</td>
    </tr>
</table>

...

### Example

    !javascript
    $('output > div').html( "" ); // Set empty on all div inside output.
    $('img[src$=.png]'); // Select all image tags that display a PNG file.


---
# Main jQuery features
## Useful methods

$(handler) : called when document is ready. (shortcut for 'ready' event)

    !javascript
    $(function() {
        doSomething( true );
    });

.html : Get or set content inside an element

    !javascript
    $("myElement").html("New content");
    alert( $("myElement").html() );

More

.addClass,
.append,
.attr,
.clone,
.css,
.empty,
...

---
# Main jQuery features
## Events

Trigger an event

    !javascript
    $("a_button").click()

Handle an event

    !javascript
    $("a_button").click(function(event) {
        doSomething();
    });

More : dblclick, change, error, focus, ready, ...

Event attributes and methods

 * pageX, pageY : mouse coordinates
 * which : key or button that was pressed.
 * preventDefault()
 * ...

---
# Main jQuery features
## jQuery UI
### Element creation

    !javascript
    $(".selector").slider({ min: 0, max: 100, step: 1, disabled: true });
    $("#progressbar").progressbar({value: 37});
    $("a_button").button();

### Events

    !javascript
    // Event on creation
    $(".selector").slider({ 
        change: function( event, ui ) {}
    });
    // Event on existing element
    $(".selector").on("slidechange", function(event, ui) {} ); 

More events for slider:

create, slide, start, stop

---
# Main jQuery features
## Ajax

jQuery ajax functions make html really easier.

    !javascript
    $.get('a_url', function(data) {
        $('.result').html(data);
        alert('Data retrieved.');
    });

    // Equivalent to 'test.php?name=John'
    $.get("test.php", { name: "John" } );

Returns a jqXHR object

 * .done(...)
 * .fail(...)

---
# Usage in Mojito webserver
## The Ugly

    !c++
    html_buffer << "<div id='tabs-race'>"
            "<div>Race A<div id='race_a' style='width:300px'></div></div>"
            "<div>Race B<div id='race_b' style='width:300px'></div></div>"
            "<div>Race C<div id='race_c' style='width:300px'></div></div>"
            "<div>Race D<div id='race_d' style='width:300px'></div></div>"
            "</div>"
            "<script> $(document).ready(function() { "
            "$('#race_a').slider({ change:function(event,ui){ $.get('/viewer?tool=" << TOOL_Custom1 << "&race=a&value=' + ui.value ) } }); \n"
            "$('#race_b').slider({ change:function(event,ui){ $.get('/viewer?tool=" << TOOL_Custom1 << "&race=b&value=' + ui.value ) } }); \n"
            "$('#race_c').slider({ change:function(event,ui){ $.get('/viewer?tool=" << TOOL_Custom1 << "&race=c&value=' + ui.value ) } }); \n"
            "$('#race_d').slider({ change:function(event,ui){ $.get('/viewer?tool=" << TOOL_Custom1 << "&race=d&value=' + ui.value ) } }); \n"
            "}); </script>";
    // ...

Unreadable, hardcoded HTML and Javascript

---
# Usage in Mojito webserver
## The Bad

    !c++
    html << "<!DOCTYPE html PUBLIC \"-// W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n";
    html << "<html>\n";
    html << "<head>\n";
    html << "<link rel=\"stylesheet\" href=\"TABLESORTER_CSS/style.css\" type=\"text/css\" media=\"print, projection, screen\"/>\n";
    html << "<script src='jquery.js'></script>\n";
    html << "<script src='tablesorter_init.js'></script>\n";
    html << "<script src='jquery.tablesorter.min.js'></script>\n";
    html << "<script src='3dworld.js'></script>\n";
    html << "</head>\n";
    // ...

Javascript is in a file but HTML is hardcoded.

---
# Usage in Mojito webserver
## The Good

 * HTML and Javascript should be in files. (g.e MOJITO/DATA/WEB)
 * C++ should only handle data requests.
 * Returned data should be in Json (using JSON_WRITER)

### In Handle( WEBSERVER_REQUEST & request )

    !c++
    if ( request.FindVariable( variable, "get" ) )
    {
        PRIMITIVE_TEXT_STREAM
            stream;

        GenerateJsonData( stream ); // Uses JSON_WRITER.

        request.WriteText( stream.GetText() );

        return BOOL_True;
    }

    // No HTML generated here.

---
# Usage in Mojito webserver
## Example

HTML

    !html
    <html>
        <head>
            <style type='text/css'> @import 'webserver.css';</style>
            <script src="jquery.js" type="text/javascript"></script>
            <script src="jquery-ui.js" type="text/javascript"></script>
            <script src="sample.js" type="text/javascript"></script>
        </head>
        <body>
            <div id="slider"/>
            <div id="data"/>
        </body>
    </html>

---
# Usage in Mojito webserver
## Example

Javascript

    !javascript
    $(function() {
        $('#slider').slider({ 
            change: function(event, ui) {
                $.get(
                    "sample",
                    { update: ui.value() },
                    function(data) { fillData(data); }
                    );
            }
        });
    });

    function fillData(data) {
        // Decode Json in data and generate text
        $('#data').html(text);
    });


---
# Usage in Mojito webserver
## Example

C++

    !c++
    if ( request.FindVariable( variable, "update" ) )
    {
        PRIMITIVE_TEXT_STREAM
            stream;

        Compute( PRIMITIVE_TEXT_GetInteger( variable ) );
        GenerateJsonData( stream );

        request.WriteText( stream.GetText() );

        return BOOL_True;
    }


---
# Usage in Mojito webserver
## Conclusion

Mojito webserver should follow the model-view-controller concept:

 * C++ to output raw json data (model)
 * HTML page to setup layout, colors, ... (view)
 * Javascript to handle data and fill the view (controller)

---
# Extra

# References

 * http://www.siteduzero.com/informatique/tutoriels/jquery-ecrivez-moins-pour-faire-plus
 * http://api.jquery.com
 * http://api.jqueryui.com

# This slideshow

Generated using 'landslide'

 * Written in python
 * Input data is in Markdown language
 * Uses Google's html5slides
 * github.com/adamzap/landslide

---
# The End

For Fishing Cactus,<br/>
by Gauthier Billot </br>
< gauthier.billot @ fishingcactus.com >