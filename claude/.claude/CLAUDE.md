# Global Preferences

## Tool Preferences

- Use uv exclusively for Python package management — never pip, pip-tools, poetry, or conda
- Run Python scripts and tools via `uv run`

## Code Style

- Don't add unnecessary comments
- Imports should be at the top of the file, never inline
- Don't leave whitespace in blank lines

## Obsidian Vault Integration

### Vault Structure

```
ai/
├── inbox/       # Tasks for LLM processing (status: pending)
├── outbox/      # Results from completed tasks
└── scratch/     # Temporary working space, safe to overwrite
```

### Processing Inbox Tasks

When asked to "process inbox", "check inbox", or work on vault tasks:

1. **List** `ai/inbox/` and read any notes with `status: pending`
2. **Read** the context files referenced in the note
3. **Execute** the task described
4. **Write result** to `ai/outbox/<original-note-name>-result.md` with frontmatter:
   - `source_task`: path to the original inbox note
   - `created`: timestamp
   - `tags`: [ai/outbox]
5. **Patch** the original inbox note: update `status: pending` → `status: done`

### Conventions

- **Read freely** from anywhere in the vault for context
- **Write only** to `ai/outbox/` or `ai/scratch/` unless the task explicitly requests writing elsewhere
- **Never delete** notes — mark as `status: archived` instead
- **Preserve frontmatter** — use `patch_note` to update fields, not `write_note`
- **Use wikilinks** (`[[note-name]]`) when referencing other vault notes in output
- When creating outbox notes, include a `## Summary` section at the top before detailed content
