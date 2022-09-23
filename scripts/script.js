import getFunctionValue from './getFunctionValue.js'

window.addEventListener('DOMContentLoaded', () => {
    const mathf = document.querySelector('#formula');
    const latexField = document.querySelector('#latex');
    const resField = document.querySelector('#result');

    latexField.addEventListener('input', () => mathf.setValue(latexField.value));
    function onMathfieldInput() {
        // Output MathJSON representation of the expression
        console.clear();
        console.log('value', mathf.value)
        console.log('MathJSON expression', mathf.expression.json);

        // Update raw LaTeX value
        latexField.value = mathf.value;

        // Get function value 
        let value = getFunctionValue(mathf, 5)
        resField.value = value && value.latex
    }
    mathf.addEventListener('input', onMathfieldInput);
    onMathfieldInput();
});