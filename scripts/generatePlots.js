import getFunctionValue from "./getFunctionValue.js"

const getFunctionPlot = (mathf, start, end) => {
    let fx = [], fz = [], fy = []
    for (let i = start; i <= end; i += 0.1) {
        fx.push(i)
        fz.push(getFunctionValue(mathf, i))
        fy.push(1)
    }
    return [fx, fz, fy]
}

export default ([...args], mathf) => {
    const [X, F, ...rest] = [...args]
    // x is x
    // z is f(x)
    let y = Array.from({ length: X.length }, (_, i) => i + 1)
    // y is i
    var col = ['green'];

    let trace0 = {
        type: 'scatter3d',
        mode: 'lines+markers',
        x: X,
        y: y,
        z: F,
        line: {
            width: 6,
            color: 'red',
            colorscale: "Viridis"
        },
        marker: {
            size: 3.5,
            // symbol: 'diamond-open',
            color: 'green',
            // colorscale: "Greens",
            cmin: -20,
            cmax: 50
        }
    }
    let backPlot = getFunctionPlot(mathf, X[0], X[X.length - 1])
    let [fx, fz, fy] = [...backPlot]
    console.log(backPlot)

    let data = [trace0]
    // process background plots
    for (let i = 1; i <= X.length; i++) {
        data.push({
            type: 'scatter3d',
            mode: 'lines',
            x: fx,
            y: fy.map(el => i),
            z: fz,
            opacity: 1,
            line: {
                width: 3,
                color: 'blue',
                reversescale: false
            }
        })
    }

    Plotly.newPlot('search-result', data);
}
