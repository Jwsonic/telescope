# Telescope

## Testing

### External tests

Tests tagged with `:external` are skipped by default. They require an Valve API key and can be run with the command: 

`TELESCOPE_VALVE_API_KEY=TheKeyGoesHere mix test --include external`