export class FutureOnceNotifier {
    constructor() {
        this._listeners = [];
    }
    get _hasEvent() {
        return this._value !== undefined;
    }
    emit(event) {
        const listeners = this._listeners.filter(v => true);
        this._value = event;
        setTimeout(() => {
            listeners.forEach((pair) => {
                pair.notify(pair.listener(event));
            });
        }, 0);
        this.dispose();
    }
    addListener(listener, notify) {
        this._listeners.push({ listener, notify });
        if (this._hasEvent)
            this.emit(this._value);
    }
    dispose() {
        this._listeners = [];
    }
}
//# sourceMappingURL=future_notifier.js.map