import { FutureListener, IFutureLike } from "../types/future.js";
import { INotifier } from "../types/future_notifier.js";
import { FutureOnceNotifier } from "./future_notifier.js";

export class Future<T, E = any> implements IFutureLike<T, E> {
    constructor(
        executor: (
            resolve: (data: T) => void, 
            reject: (raison?: E) => void
        ) => void
    ) {        
        const resolveNotifier = new FutureOnceNotifier<T>();
        const rejectNotifier = new FutureOnceNotifier<E>();

        this._promiseResolveNotifier = resolveNotifier;
        this._promiseRejectNotifier = rejectNotifier;

        executor(
            resolveNotifier.emit.bind(resolveNotifier), 
            rejectNotifier.emit.bind(rejectNotifier)
        );
    }

    then<R = T>(
        onSuccess: FutureListener<T, R>, 
    ): IFutureLike<R, E> {        
        const resolveNotifier = this._promiseResolveNotifier;
        return new Future<R, E>((resolve, _) => {
            resolveNotifier.addListener(onSuccess, resolve);
        });
    }

    catch<R = never>(onError: FutureListener<E, R>): IFutureLike<R, E> {
        const rejectNotifier = this._promiseRejectNotifier;
        return new Future<R, E>((resolve, _) => {
            rejectNotifier.addListener(onError, resolve);
        });
    }

    private _promiseResolveNotifier: INotifier<T>;
    private _promiseRejectNotifier: INotifier<E>;
}
