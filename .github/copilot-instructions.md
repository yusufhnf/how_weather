# Copilot Instructions for How Weather App Project

## General Guidelines
- Be concise and direct
- Prefer single-line outputs when possible
- Avoid emojis in all outputs
- Avoid unnecessary explanations
- Do not add bullet points unless explicitly asked

## Git Commit Messages
- Use a single short sentence (imperative tone)
- Start with a verb (e.g., "Add", "Fix", "Update", "Remove")
- Keep under 50 characters when possible
- No periods at the end
- Examples:
  - "Add scroll indicator color customization"
  - "Fix scrollbar theme positioning"
  - "Update organizational unit list styling"

## Code Comments
- Keep comments minimal and meaningful
- Explain "why" not "what" when the code is clear
- Use single-line comments for brief explanations

## Architecture Adherence
- Follow Clean Architecture patterns as defined in rules.md
- Use BLoC/Cubit for state management
- Apply Freezed for all data classes
- Implement proper dependency injection with Injectable/GetIt
