import getFunctionValue from "./getFunctionValue.js"

const get2dFunctionPlot = (mathf, start, end) => {
    let fx = [], fy = []
    for (let i = start; i <= end; i += 0.1) {
        fx.push(i)
        fy.push(getFunctionValue(mathf, i))
    }
    return [fx, fy]
}

export default ([...args], mathf) => {
    const [X, F, ...rest] = [...args]
    // x is x
    // z is f(x)
    let y = Array.from({ length: X.length }, (_, i) => i + 1)
    // y is i
    var col = Array();

    let trace0 = {
        mode: 'lines+markers',
        x: X,
        y: F,
        line: {
            width: 3,
            color: 'red',
        },
        marker: {
            opacity: 1,
            size: y.map(num => (num === 1 || num === y[y.length - 1]) ? 17 : 10),
            symbol: y.map(num => num === y[y.length - 1] ? 'diamond' : 'circle'),
            color: y.map(num => num === 1 ? 'green' : 'yellow'),
        },
        hovertemplate: 'x = %{x}<br>' + 'f(x) = %{y}<br>' + '<extra></extra>',
    }
    let backPlot = get2dFunctionPlot(mathf, X[0], X[X.length - 1])
    let [fx, fy] = [...backPlot]

    let data = [{
        mode: 'lines',
        x: fx,
        y: fy,
        opacity: 1,
        line: {
            width: 2,
            color: 'blue',
        },
        hovertemplate: 'x = %{x}<br>' + 'f(x) = %{y}<br>' + '<extra></extra>',
    }, trace0]

    const layout = {
        showlegend: false,
        title: 'Графік пошуку інтервала невизначенності методом Свенна',
    }

    Plotly.newPlot('search-process', data, layout);
}
