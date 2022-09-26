import { ComputeEngine } from
    'https://unpkg.com/@cortex-js/compute-engine?module';
const ce = new ComputeEngine();

const getFunctionValue = (func, x) => { // get mathf and x
    // get ce object
    let expr = ce.parse(func.value)
    // replace variable x with value
    expr = expr.subs({ x: ce.box(x) });
    // get result`s slice
    let equal = expr.json.slice(1, expr.json.length - 1)
    // tranform slice to ce object
    let eqExpr = ce.parse(ce.serialize(equal[0]))
    // get result value
    let res = parseFloat(eqExpr.N().latex)
    // console.log(x, equal, res)
    return !isNaN(res) ? res : null
}

export default getFunctionValue