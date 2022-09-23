import { ComputeEngine } from
    'https://unpkg.com/@cortex-js/compute-engine?module';
const ce = new ComputeEngine();

const getFunctionValue = (func, x) => { // get mathf and x
    if (!func || !x)
        return false
    let expr = ce.parse(func.value)
    console.log(expr.json);
    expr = expr.subs({ x: ce.box(x) });
    console.log(`Substitute x -> ${x}\t`, expr.json);
    console.log("Numerical Evaluation\t", expr.latex);
    return expr
}

export default getFunctionValue