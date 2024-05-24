import {isHomeCheck} from './isHome.js';
import {requestProducts} from './loadProducts.js';

document.addEventListener("DOMContentLoaded", function () {
    isHomeCheck();
    requestProducts();
});