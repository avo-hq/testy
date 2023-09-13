const avoPath = require('child_process').execSync('bundle show avo', { encoding: 'utf-8' }).trim()

const { avoConfig } = require(`${avoPath}/tailwind.config.integration.js`)

// Generating Avo Tailwind configuration for avo
let avoConfiguration = avoConfig(avoPath)

// Merging Avo Tailwind configuration with app configuration
// Adding app content
avoConfiguration.content.push(
  ...[
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
  ]
)

// Add whatever you want to the configuration

module.exports = avoConfiguration
