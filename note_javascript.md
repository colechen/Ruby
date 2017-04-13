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
### Constraint Validation DOM Methods
| Property | Description |
| --- | --- |
| checkValidity() | Returns true if an input element contains valid data. |
| setCustomValidity() | Sets the validationMessage property of an input element. |
