import { FutureOnceNotifier } from "./future_notifier.js";
export class Future {
    constructor(executor) {
        const resolveNotifier = new FutureOnceNotifier();
        const rejectNotifier = new FutureOnceNotifier();
        this._promiseResolveNotifier = resolveNotifier;
        this._promiseRejectNotifier = rejectNotifier;
        executor(resolveNotifier.emit.bind(resolveNotifier), rejectNotifier.emit.bind(rejectNotifier));
    }
    then(onSuccess) {
        const resolveNotifier = this._promiseResolveNotifier;
        return new Future((resolve, _) => {
            resolveNotifier.addListener(onSuccess, resolve);
        });
    }
    catch(onError) {
        const rejectNotifier = this._promiseRejectNotifier;
        return new Future((resolve, _) => {
            rejectNotifier.addListener(onError, resolve);
        });
    }
}
//# sourceMappingURL=future.js.map