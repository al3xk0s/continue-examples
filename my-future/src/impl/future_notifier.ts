import { FutureListener } from "../types/future.js";
import { INotifier, ListenerNotifyPair } from "../types/future_notifier.js";

export class FutureOnceNotifier<T> implements INotifier<T> {
    private _value?: T;
    private get _hasEvent() {
        return this._value !== undefined;
    }

    emit(event: T): void {
        const listeners = this._listeners.filter(v => true);
        this._value = event;

        setTimeout(() => {
            listeners.forEach((pair: ListenerNotifyPair<T, any>) => {
                pair.notify(pair.listener(event));
            });
        }, 0);

        this.dispose();
    }

    addListener<R>(listener: FutureListener<T, R>, notify: (event: R) => void): void {
        this._listeners.push({listener, notify});
        if(this._hasEvent) this.emit(this._value)
    }

    dispose(): void {
        this._listeners = [];
    }

    private _listeners: ListenerNotifyPair<T, any>[] = [];
}