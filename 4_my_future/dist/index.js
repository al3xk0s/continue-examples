import { Future } from "./impl/future.js";
const future = new Future((res) => {
    res(43);
});
console.log('before');
future
    .then((d) => d * 2)
    .then(d => console.log(d));
console.log('later');
//# sourceMappingURL=index.js.map