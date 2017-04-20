## Javascript Note from w3schools

- Placing scripts in external files has some advantages:

    It separates HTML and code
    It makes HTML and JavaScript easier to read and maintain
    **Cached JavaScript files can speed up page loads**

- **Placing scripts at the bottom of the `<body>` element** improves the display speed, because script compilation slows down the display.

- Using **document.write() after an HTML document** is fully **loaded**, will **delete all existing HTML**

- If you re-declare a JavaScript variable, it will not lose its value.

- The typeof operator returns the type of a variable or an expression

- Empty an object by setting it to null -> Value is null, but type is still an object<br />
Empty an object by setting it to undefined -> Value is undefined, type is undefined

- In HTML, the global scope is the window object. All **global variables** belong to the **window object**.
    ```javascript
    var carName = "Volvo";
    // code here can use window.carName
    ```

- Comparing two different JavaScript objects will always return false.

- By default, the string replace() function replaces only the first match. To replace all matches, use a regular expression with a g flag (for global match)
    ```javascript
    str = "Please visit Microsoft!";
    var n = str.replace(/Microsoft/g, "W3Schools");
    ```
- Trying to do arithmetic with a non-numeric string will result in NaN (Not a Number). If the string contains a numeric value, the result will be a number.
    ```javascript
    var x = 100 / "Apple";  // x will be NaN (Not a Number)
    var x = 100 / "10";     // x will be 10
    
    var x = 100 / "Apple";
    isNaN(x);               // returns true because x is Not a Number 
    
    typeof Infinity;        // returns "number"
    typeof NaN;             // returns "number"
    ```

- Array.isArray() (ECMAScript 5) is not supported in older browsers. To create your own isArray() function that returns true if the object prototype contains the word "Array".
    ```javascript
    function isArray(x) {
        return x.constructor.toString().indexOf("Array") > -1;
    }
    function isArraySimpler(x) {
        return x.constructor === Array;
    ```
    OR<br />
    The instanceof operator returns true if an object is created by a given constructor
    ```javascript
    var fruits = ["Banana", "Orange", "Apple", "Mango"];
    fruits instanceof Array     // returns true
    ```

- **Sorting** javaScript **arrays** often contain **objects**
    ```javascript
    var cars = [
        {type:"Volvo", year:2016},
        {type:"Saab", year:2001},
        {type:"BMW", year:2010}];
        
    //sort by numeric property
    cars.sort(function(a, b){return a.year - b.year});
    
    //sort by string property
    cars.sort(function(a, b){
        var x = a.type.toLowerCase();
        var y = b.type.toLowerCase();
        if (x < y) {return -1;}
        if (x > y) {return 1;}
        return 0;
    });
    ```
-   The data type of NaN is number<br />
    The data type of an array is object<br />
    The data type of a date is object<br />
    The data type of null is object<br />
    The data type of an undefined variable is **undefined**<br />
    The data type of a variable that has not been assigned a value is also **undefined**<br />

- Better and faster Code
    ```javascript
    var i;
    var l = arr.length;
    for (i = 0; i < l; i++) {
    ```

- **Add script** to the page **by code**, after the page has loaded
    ```html
    <script>
    window.onload = function() {
        var element = document.createElement("script");
        element.src = "myScript.js";
        document.body.appendChild(element);
    };
    </script>
    ```
    
    
- Constraint Validation DOM Methods

  | Property | Description |
  | --- | --- |
  | checkValidity() | Returns true if an input element contains valid data. |
  | setCustomValidity() | Sets the validationMessage property of an input element. |
  
- JavaScript **Closures**
    ```javascript
    var add = (function () {
        var counter = 0;
        return function () {return counter += 1;}
    })();

    add();
    add();
    add();

    // the counter is now 3
    ```
    >The variable add is assigned the return value of a self-invoking function.<br />
    >The self-invoking function only runs once. It sets the counter to zero (0), and returns a function expression.<br />
    >This way add becomes a function. The "wonderful" part is that it can access the counter in the parent scope.<br />
    >This is called a JavaScript closure. It makes it possible for a function to have "private" variables.<br />
    >The counter is protected by the scope of the anonymous function, and can only be changed using the add function.<br />
    
    `A closure is a function having access to the parent scope, even after the parent function has closed.`

- Finding HTML Elements

  | Method | Description |
  | --- | --- |
  | document.getElementById(id) |	Find an element by element id |
  | document.getElementsByTagName(name) |	Find elements by tag name |
  | document.getElementsByClassName(name) |	Find elements by class name |
  | document.querySelectorAll(css selector) | Find element by CSS Selectors (i.e. p.intro) |
  
- Changing HTML Elements

  | Method | Description |
  | --- | --- |
  | element.innerHTML =  new html content |	Change the inner HTML of an element | 
  | element.attribute = new value |	Change the attribute value of an HTML element |
  | element.setAttribute(attribute, value) |	Change the attribute value of an HTML element |
  | element.style.property = new style |	Change the style of an HTML element |

- Adding and Deleting Elements

  | Method | Description |
  | --- | --- |
  | document.createElement(element) |	Create an HTML element |
  | document.removeChild(element) |	Remove an HTML element |
  | document.appendChild(element) |	Add an HTML element |
  | document.replaceChild(element) | Replace an HTML element |
  | document.write(text) |	Write into the HTML output stream |
  
- Adding Events Handlers

  | Method | Description |
  | --- | --- |
  |  document.getElementById(id).onclick = function(){code} |	Adding event handler code to an onclick event |
  
- Write directly to the HTML output stream
    ```javascript
    document.write(Date());
    ```
    
- Create the Animation Using JavaScript <br />
    ```javascript
    myVar = setInterval("javascript function", milliseconds);
    clearInterval(myVar); //id_of_setinterval, The ID of the timer returned by the setInterval() method.
    ```
    >The clearInterval() method clears a timer set with the setInterval() method.<br />
    >The ID value returned by setInterval() is used as the parameter for the clearInterval() method.<br />
    >To be able to use the clearInterval() method, you must use a global variable when creating the interval method<br />
    >Be able to stop the execution by calling the clearInterval() method.<br />
    
    >[moving object](https://www.w3schools.com/js/tryit.asp?filename=tryjs_dom_animate_3)<br />
    >[running clock](https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_clearinterval)<br />
    >[change color continuously](https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_setinterval_clearinterval2) <br />
    >[progress bar](https://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_win_setinterval_progressbar)<br />

- Window setTimout() Method
    ```javascript
    setTimeout(function(){ alert("Hello"); }, 3000);
    window.scrollTo(500,0);
    window.blur();
    ```
    >[Windows Object List](https://www.w3schools.com/jsref/obj_window.asp)
    
- Add proprety and method to a Prototype
    ```javascript
    function Person(first, last, age, eyecolor) {
        this.firstName = first;
        this.lastName = last;
        this.age = age;
        this.eyeColor = eyecolor;
    }
    Person.prototype.nationality = "English";
    Person.prototype.name = function() {
        return this.firstName + " " + this.lastName;
    }; 
    ```

- Dom Events<br />
    https://www.w3schools.com/jsref/dom_obj_event.asp
    
- Dom EventListener <br />
    ```javascript
    //syntax: useCapture: bubble up (default), capture down
    element.addEventListener(event, function, useCapture);

    element.addEventListener("click", function(){ alert("Hello World!"); });
    
    element.addEventListener("click", myFunction);
    function myFunction() {
        alert ("Hello World!");
    }
    //Window Object
    window.addEventListener("resize", function(){
        document.getElementById("demo").innerHTML = sometext;
    }); 
    
    element.removeEventListener("mousemove", myFunction);
    ```
    
- Different way to retrieve node value
    ```javascript
     <title id="demo">DOM Tutorial</title> 
     var myTitle = document.getElementById("demo").innerHTML; 
     var myTitle = document.getElementById("demo").firstChild.nodeValue;
     var myTitle = document.getElementById("demo").childNodes[0].nodeValue; 
     ```

- Add/remove HTML Elements (Nodes)
    ```html
    <div id="div1">
    <p id="p1">This is a paragraph.</p>
    <p id="p2">This is another paragraph.</p>
    </div>

    <script>//add
    var para = document.createElement("p");
    var node = document.createTextNode("This is new.");
    para.appendChild(node);

    var element = document.getElementById("div1");
    element.appendChild(para);
    //element.insertBefore(para, document.getElementById("p1");
    </script>
    
    <script>//remove
    var parent = document.getElementById("div1");
    var child = document.getElementById("p1");
    parent.removeChild(child);
    //child.parentNode.removeChild(child); //short form
    </script>
    ```
    
- Replace HTML Elements
    ```html
    <div id="div1">
    <p id="p1">This is a paragraph.</p>
    <p id="p2">This is another paragraph.</p>
    </div>

    <script>
    var para = document.createElement("p");
    var node = document.createTextNode("This is new.");
    para.appendChild(node);

    var parent = document.getElementById("div1");
    var child = document.getElementById("p1");
    parent.replaceChild(para, child);
    </script>
    ```
    
- Window Object
    ```javascript
    //window size
    var w = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    var h = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight; 
    ```
    >window.open() - open a new window <br />
    >window.close() - close the current window <br />
    >window.moveTo() -move the current window <br />
    >window.resizeTo() -resize the current window <br />

- Window Location <br />
    window.location.href returns the href (URL) of the current page <br />
    window.location.hostname returns the domain name of the web host <br />
    window.location.pathname returns the path and filename of the current page <br />
    window.location.protocol returns the web protocol used (http: or https:) <br />
    window.location.assign loads a new document <br />
    
- Window History <br />
    window.history.back() <br />
    window.history.forward() <br />

- Window Navigator <br />
    window.navigator.cookieEnabled <br />
    window.navigator.userAgent //returns the user-agent header sent by the browser to the server <br />
    window.navigator.platform <br />
    window.navigator.language <br />
    window.navigator.javaEnabled() <br />

- JavaScript Popup Boxes
    ```javascript
    window.alert("I am an alert box!");
    
    function myConfirm() {
        var x;
        if (window.confirm("Press a button!") == true) {
            x = "You pressed OK!";
        } else {
            x = "You pressed Cancel!";
        }
        document.getElementById("demo").innerHTML = x;
    }
    
    function myPrompt() {
        var person = prompt("Please enter your name", "Harry Potter");

        if (person != null) {
            document.getElementById("demo").innerHTML =
            "Hello " + person + "! How are you today?";
        }
    }
    ```

- JavaScript Cookies
    ```javascript
    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function checkCookie() {
        var user = getCookie("username");
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                setCookie("username", user, 365);
            }
        }
    }
    ```

- AJAX (Asynchronous Javascript And XML<br />
    Note: The onreadystatechange function is called every time the readyState changes.
    ```html
    <script>
    function loadDocGet() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("demo").innerHTML =
          this.responseText;
        }
      };
      xhttp.open("GET", "ajax_info.txt", true);
      xhttp.send();
    }
    
    function loadDocPost() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("demo").innerHTML = this.responseText;
        }
      };
      xhttp.open("POST", "demo_post2.asp", true);
      xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");//To POST data like an HTML form
      xhttp.send("fname=Henry&lname=Ford");
    }
    
    function loadDocAsyncFalse() {
      var xhttp = new XMLHttpRequest();
      xhttp.open("GET", "ajax_info.txt", false); //async is false. call will be synchronous and wait for response
      xhttp.send();
      document.getElementById("demo").innerHTML = xhttp.responseText;
    }
    </script>
    ```
    ```html
    //define function ajax call
    <button type="button"
    onclick="loadDoc('ajax_info.txt', myFunction)">Change Content
    </button>
    

    <script>
    function loadDoc(url, cFunction) {
      var xhttp;
      xhttp=new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          cFunction(this);
        }
      };
      xhttp.open("GET", url, true);
      xhttp.send();
    }
    function myFunction(xhttp) {
      document.getElementById("demo").innerHTML =
      xhttp.responseText;
    }
    </script>
    ```
    ```html
    <script>
    //parse the response as an XML DOM object
    var xhttp, xmlDoc, txt, x, i;
    xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      xmlDoc = this.responseXML;
      txt = "";
      x = xmlDoc.getElementsByTagName("ARTIST");
      for (i = 0; i < x.length; i++) {
        txt = txt + x[i].childNodes[0].nodeValue + "<br>";
      }
      document.getElementById("demo").innerHTML = txt;
      }
    };
    xhttp.open("GET", "cd_catalog.xml", true);
    xhttp.send();
    </script>
    ```
    ```html
    <script>
    //getAllResponseHeaders()
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("demo").innerHTML =
        this.getAllResponseHeaders();
      }
    };
    xhttp.open("GET", "ajax_info.txt", true);
    xhttp.send();
    </script>
    ```
    ```html
    //getResponseHeader()
    <script>
    var xhttp=new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("demo").innerHTML =
        this.getResponseHeader("Last-Modified");
      }
    };
    xhttp.open("GET", "ajax_info.txt", true);
    xhttp.send();
    </script>
    ```
    >Example for xml parsing: https://www.w3schools.com/js/tryit.asp?filename=tryjs_ajax_xml2
    >Other examples: https://www.w3schools.com/js/js_ajax_examples.asp
    
- XMLHttpRequest Object Methods

    Method | Description
    --- | ---
    new XMLHttpRequest() | Creates a new XMLHttpRequest object
    abort() | Cancels the current request
    getAllResponseHeaders() | Returns header information
    getResponseHeader() | Returns specific header information
    open(method, url, async, user, psw) | Specifies the request<br />method: the request type GET or POST<br />url: the file location<br />async: true (asynchronous) or false (synchronous)<br />user: optional user name<br />psw: optional password
    send() | Sends the request to the server<br /> Used for GET requests
    send(string) | Sends the request to the server.<br /> Used for POST requests
    setRequestHeader() | Adds a label/value pair to the header to be sent
    
- XMLHttpRequest Object Properties

    Property |	Description
    --- | ---
    onreadystatechange |	Defines a function to be called when the readyState property changes
    readyState |	Holds the status of the XMLHttpRequest.<br />0: request not initialized<br />1: server connection established<br />2: request received<br />3: processing request<br />4: request finished and response is ready
    responseText |	Returns the response data as a string
    responseXML |	Returns the response data as XML data
    status |	Returns the status-number of a request<br />200: "OK"<br />403: "Forbidden"<br />404: "Not Found"<br />For a complete list go to the Http Messages Reference
    statusText |	Returns the status-text (e.g. "OK" or "Not Found")
    
- 
