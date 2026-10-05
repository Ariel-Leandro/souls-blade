/// @function approach(atual, destino, quantidade)
/// @description Aproxima um valor do valor de destino a uma taxa fixa
function approach(_val1, _val2, _amount) {
    if (_val1 < _val2) {
        return min(_val1 + _amount, _val2);
    } else {
        return max(_val1 - _amount, _val2);
    }
}