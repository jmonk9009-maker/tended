# TENDED AGENT RULES — v2.0
# Last Updated: April 14, 2026
# These rules apply to ALL agents working on Tended code.

## GOLDEN RULE
Do NOT tell James something is done until you have VERIFIED it works. "Pushed to main" is not done. "Deployed and tested" is done.

## BEFORE YOU BUILD
1. Read TENDED-MISSION.md and CLAUDE.md before every task
2. Understand the FULL scope of what's being asked — not just the code change, but the user experience
3. If the task involves a user-facing flow (onboarding, login, signup, checkout, etc.), map out every step the user takes BEFORE writing code
4. Ask yourself: "If James creates a new account right now and goes through this flow, will it work perfectly from start to finish?"

## WHILE YOU BUILD
1. One commit per completed task, not per individual file
2. Include ALL files needed for the feature to work — routes, components, API endpoints, types, database changes
3. If a feature requires a database migration, include the migration SQL in the commit AND remind James to run it
4. If a feature requires environment variables, check .env.local to see if they exist. Report any missing ones.
5. Do not create worktrees — work directly on the current branch
6. Do not leave TODO comments in code — finish it or don't ship it

## AFTER YOU BUILD — MANDATORY TESTING CHECKLIST
Before telling James anything is done, complete ALL of these:

### 1. Build check
- Run: npm run build
- ZERO errors required. Warnings are okay. Errors are not.
- If build fails, fix it before reporting.

### 2. Type check
- Run: npx tsc --noEmit
- ZERO TypeScript errors required.

### 3. Route verification
- For any new pages created, verify the route exists: curl -s -o /dev/null -w "%{http_code}" https://app.usetended.com/[route]
- Must return 200, not 404.
- If the deploy hasn't finished, wait for it or force deploy first.

### 4. Flow testing (for user-facing changes)
- Trace the ENTIRE user flow from start to finish
- For login/signup: Can a user actually create an account and land on the right page?
- For onboarding: Does every step render? Do answers save? Does the final step redirect correctly?
- For payments: Does the Stripe checkout link work? Does the webhook update the tier?
- For any form: Do all fields validate? Does submit work? Does the success state show?
- Check on the business subdomain AND the app subdomain if the change affects both.

### 5. Mobile check
- Check that no component uses hardcoded widths over 375px
- Check that touch targets are 44px minimum
- Check that text doesn't overflow containers

### 6. Database check
- If the code references a table or column, verify it exists in Supabase
- If a migration is needed, include the SQL and flag it prominently in your report

## REPORT FORMAT
When reporting back to James, use this exact format:

WHAT WAS BUILT: [one sentence summary]

FILES CHANGED: [list of files]

TESTING:
- Build: PASS/FAIL
- TypeScript: PASS/FAIL  
- Routes verified: [list of URLs checked with status codes]
- Flow tested: [describe the flow you tested and result]
- Mobile: PASS/FAIL

MIGRATIONS NEEDED: [SQL to run, or "None"]
ENV VARS NEEDED: [any missing, or "None"]
DEPLOY STATUS: [deployed/deploying/needs force deploy]

KNOWN ISSUES: [anything that doesn't work yet, or "None"]

## BUSINESS SUBDOMAIN RULES
- business.usetended.com is a SEPARATE experience from app.usetended.com
- Business login, onboarding, dashboard, and pricing are ALL different from personal
- When building business features, ALWAYS test on the business subdomain
- Business users should NEVER see personal onboarding, asset cards, or consumer pricing
- Personal users should NEVER see business onboarding or business dashboard

## CODE STANDARDS
- Use TypeScript strictly — no 'any' types
- Use server components by default, client components only when needed
- All API routes must verify authentication
- Admin routes must verify app_metadata.role === 'admin'
- All database queries must work with RLS enabled
- No console.log in production code — use proper error handling
- No hardcoded URLs — use environment variables or relative paths
- Mobile-first responsive design — test at 375px width

## WHAT NOT TO DO
- Do not create features that half-work
- Do not push code that doesn't build
- Do not say "follow-up task needed" for core functionality — finish it now
- Do not create placeholder pages that say "Coming Soon" unless James specifically asks
- Do not assume a database table exists — verify it
- Do not assume an environment variable is set — check it
- Do not create new git worktrees
