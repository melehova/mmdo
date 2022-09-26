import { ComputeEngine } from
    'https://unpkg.com/@cortex-js/compute-engine?module';
import getFunctionValue from './getFunctionValue.js';

/* input:
f (x) – цільова функція, x0 – вихідна точка пошуку, h – початковий
крок, N – максимальна кількість точок;
 */

/* output:
X – масив усіх точок пошуку xk ; F – масив відповідних значень
функції fk = f (xk ) ; a і b – межі інтервалу невизначеності; fa і fb – значення функції на кінцях інтервалу;
c і fc – внутрішня точка інтервалу та значення функції в ньому; */
const createRow = (...args) => {
    const [tag, ...cellsContent] = [...args]
    let tr = document.createElement('tr')
    cellsContent.map(content => {
        let td = document.createElement(tag)
        td.textContent = content
        tr.appendChild(td)
    })
    return tr
}

export default (...args) => { // func, start point, step, max num of points 
    // desctructurising of args
    let [func, c, h, N] = [...args];
    // init variables
    const table = document.querySelector('table#results')
    // table.appendChild(createCell('th', 'a', 'b', 'c'))
    let b = 0, a = 0, fa = 0, fb = 0, fc = 0, i = 0, X = [], F = [];
    // simplify function call
    const f = x => {
        let res = getFunctionValue(func, x)
        X.push(x)
        F.push(res)
        return res
    }

    // args validation
    if (args.length !== 4)
        return null
    for (let arg of args) {
        if (typeof arg === 'undefined' || arg === null)
            return null
    }
    
    table.appendChild(createRow('th', 'i', 'h', 'f(x)', 'x'))
    // 1
    fc = f(c);
    b = c + h;
    fb = f(b);
    table.appendChild(createRow('td', ++i, h, fc, c))
    table.appendChild(createRow('td', ++i, h, fb, b))
    // 2
    maincond: if (fb >= fc) {
        // 6
        a = c - h;
        fa = f(a)
        table.appendChild(createRow('td', ++i, h, fa, a))
        // 7
        if (fa >= fc) {
            break maincond // > 11 stop
        } else {
            while (true) {
                // 8
                b = c;
                fb = fc;
                c = a;
                fc = fa;
                h *= 2;
                // 9
                a = c - h;
                fa = f(a);
                table.appendChild(createRow('td', ++i, h, fa, a))
                // 10
                if (fa < fc)
                    continue // > 8
                else
                    break // > 11 stop
            }
        }
    } else {
        while (true) {
            // 3
            a = c;
            fa = fc;
            c = b;
            fc = fb;
            h *= 2;
            // 4
            b = c + h;
            fb = f(b);
            table.appendChild(createRow('td', ++i, h, fb, b))
            // 5 
            if (fb < fc)
                continue // > 3
            else
                break // > 11 stop
        }
    }
    console.log(X, F)
    let div = document.querySelector('div#result-description')
    let ret = {
        i: i,
        h: h,
        fa: fa,
        a: a,
        fb: fb,
        b: b,
        fc: fc,
        c: c,
    }
    Object.keys(ret).forEach(key => {
        let p = document.createElement('div')
        p.textContent = `${key} = ${ret[key]}`
        div.appendChild(p)
    })
    return [X, F, a, b, fa, fb, c, fc]
}

