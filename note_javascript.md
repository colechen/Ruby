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
    ```javascript
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
    ```
    [Windows Object List](https://www.w3schools.com/jsref/obj_window.asp)
