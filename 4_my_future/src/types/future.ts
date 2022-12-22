export type FutureListener<T, R> = (event: T) => R;

export interface IFutureLike<T, E = any> {
    then<R = T>(
        onSuccess: FutureListener<T, R>, 
    ): IFutureLike<R>;

    catch<R = never>(
        onError: FutureListener<E, R>
    ) : IFutureLike<R>;
}