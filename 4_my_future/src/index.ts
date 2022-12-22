import { Future } from "./impl/future.js";

const future = new Future<number, Error>((res) => {
    res(43);
});

console.log('before')

future
.then((d) => d * 2)
.then(d => console.log(d));

console.log('later')


// Вывод:
//
// before
// later
// 86