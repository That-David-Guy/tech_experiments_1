
// FROM https://www.w3schools.com/howto/howto_js_draggable.asp
// TODO Move this.hook out to a call back, these functions shouldn't know abou it
function dragElement(element, onCloseDragElement) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(element.id + "_draggable")) {
    // if present, the draggable element where you move the DIV from:
    document.getElementById(element.id + "_draggable").onmousedown = dragMouseDown;
  } else {
    // otherwise, move the DIV from anywhere inside the DIV: 
    element.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;

    element.classList.add("mum_dragging");
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    element.style.top = (element.offsetTop - pos2) + "px";
    element.style.left = (element.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;

    element.classList.remove("mum_dragging");

    const newX = (element.offsetLeft - pos1)
    const newY = (element.offsetTop - pos2) 
    onCloseDragElement && onCloseDragElement(newX, newY)
  }
}

export function mutateHooks(Hooks) {
    console.log("mutateHooks", Hooks)

    Hooks.mum_draggableCharacters = {
        mounted() {
            // NOTE: pushEventTo to go to the component, use pushEvent to go to the liveView
            const onCloseDragElement = (position_x, position_y) => 
              this.pushEventTo(`#${this.el.id}`, "dragged", {position_x, position_y})
            

            dragElement(this.el, onCloseDragElement)
        }
    }
}