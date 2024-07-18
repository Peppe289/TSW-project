/**
 * Use also as module for show toast popup.
 *
 * @module ToastAPI
 */
let box = document.getElementById("nofifyBox");

/**
 * Remove element from notify area
 *
 * @function exitAnimation
 * @param element - element to remove from notify area using animation.
 * @param {Function} callback - callback function for remove.
 */
function exitAnimation(element, callback) {
    let opacity = 1;
    let interval = setInterval(opacityScale, 30);
    function opacityScale() {
        if (opacity < 0.0 || opacity === 0.0) {
            clearInterval(interval);
            callback();
        } else {
            opacity = (opacity - 0.1).toFixed(2);
            element.style.opacity = opacity;
        }
    }
}

/**
 * Help span to show animation when new notify become.
 *
 * @function exitAnimation - function called from this (see below)
 * @function notifyAnimation
 * @param element - element that needs animation
 */
function notifyAnimation(element) {
    let pos = 0;
    let interval = setInterval(animation, 20);
    function animation() {
        if (pos === 100) {
            clearInterval(interval);
            exitAnimation(element.parentElement, function() {
                // Remove the element only after the exitAnimation is complete
                box.removeChild(element.parentElement);
            });
        } else {
            pos++;
            element.style.width = pos + "%";
        }
    }
}

/**
 * Standard function called for show new notify.
 *
 * @function notifyUser
 * @param header - This string will show text as h1.
 * @param message - This string will show text as paragraph.
 */
function notifyUser(header, message) {
    const notify = document.createElement("div");
    /**
     * Crea la prima volta il div box dove usciranno le notifiche
     */
    if (box === null) {

        /**
         * We can't print on the footer. so if isn't present print on bottom right of the page,
         * if is present consider heigth of footer and
         */
        try {
            const footer = document.getElementsByTagName("footer")[0];
            box = document.createElement("div");
            box.setAttribute("id", "nofifyBox");
            document.getElementsByTagName("body")[0].appendChild(box);
            let positionInfo = footer.getBoundingClientRect();
            //box.style.bottom = (box.style.bottom ? parseInt(box.style.bottom) : 0) + positionInfo.height + "px";
            box.style.bottom = positionInfo.height + "px";
        } catch (e) {
            box = document.createElement("div");
            box.setAttribute("id", "nofifyBox");
            document.getElementsByTagName("body")[0].appendChild(box);
        }
    }

    notify.classList.add("notify");
    notify.innerHTML = "    <div class=\"box\">\n" +
        "        <h1>" + header + "</h1>\n" +
        "        <p>" + message + "</p>\n" +
        "    </div>\n" +
        "    <span></span>\n";

    box.appendChild(notify);
    notifyAnimation(notify.getElementsByTagName("span")[0]);
}

/**
 * module function called for show new notify.
 *
 * @function notifyUser - function called
 * @function notifyUserModule
 * @param header - This string will show text as h1.
 * @param message - This string will show text as paragraph.
 */
export function notifyUserModule(header, message) {
    notifyUser(header, message);
}