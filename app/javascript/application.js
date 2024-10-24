// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import { Application } from "@hotwired/stimulus"

// Initialize Stimulus Application
const application = Application.start()
application.debug = false
window.Stimulus = application

// Eagerly load all controllers defined in the "controllers" directory
eagerLoadControllersFrom("controllers", application)

export { application }
