import { FutureListener } from "./future.js";

export interface INotifier<T> {
    emit(event: T) : void;
    addListener<R>(listener: FutureListener<T, R>, notify: (event: R) => void) : void;
    dispose() : void;
}

export interface ListenerNotifyPair<T, R> {
    listener: FutureListener<T, R>,
    notify: (event: R) => void
}