import getFunctionValue from './getFunctionValue.js'
import svennFunction from './svennFunction.js'
import generate3dPlot from './generate3dPlot.js'
import generate2dPlot from './generate2dPlot.js'

window.addEventListener('DOMContentLoaded', () => {
    const mathf = document.querySelector('#formula');
    const latexField = document.querySelector('#latex');
    const testField = document.querySelector('#test');
    const startField = document.querySelector('#start');
    const stepField = document.querySelector('#step');

    latexField.addEventListener('input', () => mathf.setValue(latexField.value));
    function onMathfieldInput() {
        const start = parseFloat(startField.value);
        const step = parseFloat(stepField.value);
        console.clear();
        // Update raw LaTeX value
        latexField.value = mathf.value;
        // Get function value 
        let svennData = svennFunction(mathf, start, step, 100)
        generate3dPlot(svennData, mathf)
        generate2dPlot(svennData, mathf)

        let value = getFunctionValue(mathf, 0)
        testField.value = value
    }
    mathf.addEventListener('input', onMathfieldInput);
    startField.addEventListener('input', onMathfieldInput);
    stepField.addEventListener('input', onMathfieldInput);

    onMathfieldInput();
});