- Placing scripts in external files has some advantages:

    It separates HTML and code
    It makes HTML and JavaScript easier to read and maintain
    **Cached JavaScript files can speed up page loads**

- **Placing scripts at the bottom of the `<body>` element** improves the display speed, because script compilation slows down the display.

- Using **document.write() after an HTML document** is fully **loaded**, will **delete all existing HTML**

- If you re-declare a JavaScript variable, it will not lose its value.

- The typeof operator returns the type of a variable or an expression

- Empty an object by setting it to null -> Value is null, but type is still an object
<br>Empty an object by setting it to undefined -> Value is undefined, type is undefined

- In HTML, the global scope is the window object. All **global variables** belong to the **window object**.
```javascript
    var carName = "Volvo";
    // code here can use window.carName
```
