import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["choice"]

  add(event) {
    event.preventDefault();
    
    const choicesContainer = this.element.querySelector("#choices");
    const index = new Date().getTime();
    const template = document.createElement("template");

    template.innerHTML = this.choiceTemplate(index);
    choicesContainer.insertAdjacentHTML("beforeend", template.innerHTML);
  }

  remove(event) {
    event.preventDefault();
    const choiceEl = event.target.closest(".choice");
  
    const destroyField = choiceEl.querySelector("input[name*='_destroy']");
    if (destroyField) {
      destroyField.value = "1";
      choiceEl.style.display = "none";
    } else {
      choiceEl.remove();
    }
  }

  choiceTemplate(index) {
    const options = Array.from({ length: 26 }, (_, i) => {
      const letter = String.fromCharCode(65 + i);
      return `<option value="${letter}">${letter}</option>`;
    }).join('');

    return `
      <c class="choice row">
        <input type="hidden" name="poll[choices_attributes][${index}][id]" id="show_choices_attributes_${index}_id">
        <div class="col-sm-1"></div>
        <div class="col-sm-1">
          <div class="mb-3">
            <select class="form-control" required="required" type="text" name="poll[choices_attributes][${index}][sort]" id="show_choices_attributes_${index}_sort">
              ${options}
            </select>
          </div>
        </div>
        <div class="col">
          <div class="mb-3">
            <input class="form-control" type="file" name="poll[choices_attributes][${index}][image]" id="poll_choices_attributes_${index}_image">
          </div>
        </div>

        <div class="col">
          <div class="mb-3">
            <input class="form-control" required="required" type="text" name="poll[choices_attributes][${index}][title]" id="show_choices_attributes_${index}_title">
          </div>
        </div>

        <div class="col">
          <div class="mb-3">
            <input class="form-control" type="text" name="poll[choices_attributes][${index}][subtitle]" id="show_choices_attributes_${index}_subtitle">
          </div>
        </div>


        <input type="hidden" name="poll[choices_attributes][${index}][poll]" value="false">

        <div class="col-sm-1 text-end">
          <button type="button" class="btn btn-danger btn-sm" data-action="click->choices#remove" data-choice-target="choice">
            Remove
          </button>
        </div>      
  </div>
    `;
  }
}
