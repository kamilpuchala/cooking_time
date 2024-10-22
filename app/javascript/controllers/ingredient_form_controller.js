import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["ingredientsFields"]

    addIngredientField() {
        const fieldHTML = `
      <div class="ingredient-field flex items-center mb-2">
        <input type="text" name="ingredients[]" placeholder="Enter an ingredient" class="border p-2 flex-grow w-full" />
        <button type="button" data-action="click->ingredient-form#removeIngredientField" class="ml-2 text-red-500">Remove</button>
      </div>`
        this.ingredientsFieldsTarget.insertAdjacentHTML('beforeend', fieldHTML)
    }

    removeIngredientField(event) {
        event.target.closest('.ingredient-field').remove()
    }
}
