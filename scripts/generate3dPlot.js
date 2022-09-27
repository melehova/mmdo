import getFunctionValue from "./getFunctionValue.js"

const get3dFunctionPlot = (mathf, start, end) => {
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
    const y = Array.from({ length: X.length }, (_, i) => i + 1)
    // y is i

    let trace0 = {
        type: 'scatter3d',
        mode: 'lines+markers',
        x: X,
        y: y,
        z: F,
        line: {
            width: 6,
            color: 'red',
        },
        marker: {
            opacity: 1,
            size: y.map(num => (num === 1 || num === y[y.length - 1]) ? 17 : 10),
            symbol: y.map(num => num === y[y.length - 1] ? 'diamond' : 'circle'),
            color: y.map(num => num === 1 ? 'green' : 'yellow'),
        },
        hovertemplate: 'x = %{x}<br>' + 'f(x) = %{z}<br>' + 'i = %{y}' + '<extra></extra>',
    }
    let backPlot = get3dFunctionPlot(mathf, X[0], X[X.length - 1])
    let [fx, fz, fy] = [...backPlot]

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
            },
            hovertemplate: 'x = %{x}<br>' + 'f(x) = %{z}<br>' + 'i = %{y}' + '<extra></extra>',
        })
    }

    const layout = {
        scene: {
            xaxis: {
                title: 'x'
            },
            yaxis: {
                title: 'i'
            },
            zaxis: {
                title: 'f(x)'
            },
        },
        showlegend: false,
        title: 'Тривимірний графік процеса пошуку інтервала невизначенності',
        scene: {
            camera: {
                center: {
                    x: 0, y: 0, z: 0
                },
                eye: {
                    x: 1.5, y: -1.5, z: 1
                },
            },
        },
    }

    Plotly.newPlot('search-result', data, layout);
}
