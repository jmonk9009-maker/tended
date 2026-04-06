═══════════════════════════════════════════════════════
TENDED AGENT RULES — Master Operating Instructions
Owner: James Monk — Tended LLC
Last Updated: April 5 2026
STOP WORD: HALT
═══════════════════════════════════════════════════════

These rules apply to every Cowork and Claude Code session. Read this file before doing anything else. These rules override any conflicting instruction.

SECURITY REPORTING:
When reporting task results to James, never include API keys, secrets, tokens, passwords, or any sensitive credentials in plain text. If a task involves sensitive material, format the report like this:

⚠️ SENSITIVE MATERIAL — DO NOT SHARE IN CHAT ⚠️
[describe what was done without showing the actual values]
The actual values are stored safely in [location where they were saved].
⚠️ END SENSITIVE MATERIAL ⚠️

This applies to: Resend API keys, Supabase keys, Stripe keys, Anthropic keys, VAPID keys, any .env values, any OAuth tokens, and any passwords. If unsure whether something is sensitive, treat it as sensitive.

PUSH RULE:
After completing all changes for a task:
1. Run npm run build to verify everything compiles
2. If the build fails, fix the error and rebuild until it passes
3. Once the build passes, git add all changed files
4. git commit with a conventional format message (feat:, fix:, chore:) summarizing all changes
5. git push origin main
6. Confirm Vercel picks up the deployment and it reaches Ready status
7. Only THEN report results back to James
8. Never report a task as complete with unpushed commits
9. If multiple files were changed across multiple fixes in one task, they go in ONE commit and ONE push at the end

PRE-FLIGHT CHECKLIST:
Before doing anything else, confirm back to James in plain English what you understood the task to be, every file you plan to touch, every external service you plan to use, and any assumptions you are making. Wait for explicit written confirmation before proceeding.

SCOPE:
Only access, read, or modify files explicitly listed in the task. Do not explore, open, or reference anything else. If completing the task would be cleaner by touching an unlisted file, stop and ask first.

CONSENT GATES:
Stop and wait for explicit written approval before sending any email via Resend, reading from or writing to any Supabase table, pushing building or deploying any code, creating editing or deleting any environment variables, making any external API call not listed in the task, deleting any file, or overwriting more than one file at a time. State clearly what you are about to do and why. Wait for approval. Proceed one file at a time.
ROLLBACK PROTECTION:
Before modifying any file, read and save its current state in full. Never overwrite without a restore point. If something goes wrong, restore immediately and report.

RATE LIMIT ON ERRORS:
If you hit an unexpected error on the same file more than 3 times, stop immediately. Do not try again. Report in plain English and wait for instruction.

SECURITY:
Never print, log, comment, or expose API keys, Supabase URLs, environment variables, or credentials anywhere. Never log, store, transmit, or expose user emails, names, or personal data. Treat all Supabase data as strictly private and confidential.

STEP BY STEP:
Present a full plan before writing a single line of code. List every file to be touched. Wait for approval. Proceed one file at a time and report completion before moving to the next.

PLAIN ENGLISH ONLY:
All updates, summaries, and reports must be in plain English with no technical jargon. If stuck, uncertain, or blocked, say so immediately. Never guess forward.

NO ASSUMPTIONS:
If anything is unclear, ambiguous, or missing, ask before proceeding. Never infer intent. Never fill in gaps independently.
QUALITY LOOP — MANDATORY:
After completing any unit of work, enter this loop. Loop ceiling is 5 iterations maximum.

THINK: Analyze output critically. Ask — does this fully satisfy the requirement, are there edge cases not handled, are there security performance or UX issues, is anything brittle unclear or assumptive, what could break in production, what would a hostile user try to exploit. List every flaw found no matter how small.

GENERATE OPTIONS: For each flaw generate at least 3 possible fixes.

ELIMINATE: Remove bad options first. For each ask — does this introduce new risk, is this overly complex, does this conflict with existing code or patterns, does this violate any rule above. Eliminate until only the best option remains.

ACT: Implement the chosen fix.

REVIEW: Re-examine full output. Report what changed since last loop in plain English.

REPEAT: Continue until zero flaws or ceiling is reached.
IF CEILING IS REACHED: Stop immediately. Deliver a plain English report containing current state of the work, every remaining flaw, options considered and why none were chosen, recommendation on how to proceed, and every decision that requires James's input. Wait for instruction before doing anything else.

FINAL DECLARATION: When loop completes with zero flaws state — Quality loop complete. Zero flaws identified. Ready for your review. Present final output for approval before any further action.

MEMORY AND LEARNING:
After every completed task in this order — first append to cowork-log.md in the repo root including date and time, what was built, files changed, key decisions and why, flaws found and how resolved, errors encountered and how handled, and anything to remember for future sessions. Second extract lessons from cowork-log.md and update CLAUDE.md so every future session benefits automatically. Third update tended-agent-rules.md if any rule should be revised based on what was learned.

cowork-log.md must be in .gitignore and never pushed to any remote repository. CLAUDE.md and tended-agent-rules.md may be pushed as they contain no sensitive data.