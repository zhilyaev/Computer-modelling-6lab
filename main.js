function lab6(N=4) {
    let l = N % 2 === 0 ? 0.4 : 0.3

    let T = N/2 + N*l/4;
    console.log(`Время обслуживания ${T}`);
    let my = 1/T;
    console.log(`Интенсивность потока обслуживания: ${my}`);

    let lja = 1/N;
    console.log(`Интенсивность потока заявок: ${lja}`);
    let q = my / (my+lja);
    console.log(`Относительная пропускная способность системы: ${q}`);

    // let reject = 1 - q
    // console.log(`Вероятность отказа: ${reject}`);

    let A = lja*q;
    console.log(`Абсолютная пропускная способность системы: ${A}`);

    let dt = 0.1;
    let eps = 0.0001;
    let t = 0;
    let P0 = [];
    let P1 = [];
    let tm = [];
    let k = 0;

    while (
         Math.abs(P(0, t, N, l) - P(0, t+dt,  N, l))
            >
         eps
        ||
         Math.abs(P(1, t , N, l)- P(1, t+dt,  N, l))
            >
         eps
        ){
        P0[k] = P(0, t, N, l);
        P1[k] = P(1, t, N, l);
        tm[k] = t;
        k = k + 1;
        t = t + dt
    }
    k = k-1;
    console.log(`tm :`);
    console.log(tm);
    console.log(`P0 : `);
    console.log(P0);
    console.log(`P1 : `);
    console.log(P1);


    let r = Math.abs(P0[k-1]-q);
    console.log(`Разница между полученным значением P0(t) и относительной пропускной способности системы: ${r}`)
}

/**
 * @return {number}
 */
function P (i, t, N, l) {
    let T = N/2 + N*l/4;
    let my = 1/T;
    let lja = 1/N;

    return i === 0
        ? my/(my+lja)+lja/(my+lja)*Math.exp(-t*(lja+my))
        : lja/(my+lja)-lja/(my+lja)*Math.exp(-t*(lja+my))
}

lab6();
