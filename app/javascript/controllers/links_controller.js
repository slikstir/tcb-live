import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  add(event) {
    event.preventDefault();
    
    const linksContainer = this.element.querySelector("#links");
    const index = new Date().getTime();
    const template = document.createElement("template");

    template.innerHTML = this.linkTemplate(index);
    linksContainer.insertAdjacentHTML("beforeend", template.innerHTML);
  }

  remove(event) {
    event.preventDefault();
    event.target.closest(".link").remove();
  }

  linkTemplate(index) {
    return `
      <div class="link row">
        <input type="hidden" name="show[links_attributes][${index}][id]" id="show_links_attributes_${index}_id">

        <div class="col">
          <div class="mb-3">
            <input class="form-control" required="required" type="text" name="show[links_attributes][${index}][label]" id="show_links_attributes_${index}_label">
          </div>
        </div>

        <div class="col">
          <div class="mb-3">
            <input class="form-control" required="required" type="url" name="show[links_attributes][${index}][url]" id="show_links_attributes_${index}_url">
          </div>
        </div>

        <input type="hidden" name="show[links_attributes][${index}][show]" value="false">

        <div class="col d-flex align-items-center justify-content-center">
          <button type="button" class="btn btn-danger" data-action="click->links#remove" data-link-target="link">
            Remove
          </button>
        </div>      
  </div>
    `;
  }
}
