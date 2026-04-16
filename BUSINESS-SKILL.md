# BUSINESS SUBDOMAIN SKILL — business.usetended.com
# Read this ENTIRE file before building ANY business feature.
# Last Updated: April 14, 2026

## ARCHITECTURE

business.usetended.com and app.usetended.com are the SAME Next.js app (tended-v2) served from the SAME Vercel deployment. The middleware detects the hostname and sets a header/cookie to determine which experience to render.

### Middleware Detection (src/middleware.ts)
- If hostname contains "business" → set x-tended-surface: business
- If hostname contains "app" or is anything else → set x-tended-surface: consumer
- Business subdomain has a PAGE ALLOWLIST — only business pages render, everything else redirects
- Consumer subdomain has a PAGE BLOCKLIST — business-only pages redirect to app.usetended.com

### Surface Detection Helper (src/lib/surface.ts)
- getRequestSurface(request) → 'business' | 'consumer'
- getClientSurface() → reads from cookie or hostname on client side
- isBusinessSurface() → boolean helper

## PAGES — BUSINESS SUBDOMAIN ONLY

These pages ONLY render on business.usetended.com. On app.usetended.com they should 404 or redirect.

### /auth/login (Business version)
- Dark navy background
- "Tended for Business" heading with logo
- Email + password login
- Google OAuth button
- "Start your 14-day free trial" link → /auth/business/signup
- Footer: support link, terms, privacy
- NO mention of personal plans, cars, or consumer features

### /auth/business/signup
- Dark navy background
- "Create your business account" heading
- Fields: Full name, Email, Password, Confirm password
- Google OAuth option
- After signup → redirect to /onboarding/business
- Must call supabase.auth.signUp() and create the user
- Set user_metadata.surface = 'business'

### /onboarding/business (6 steps, one per screen)
Step 1: Company name (text input, required)
Step 2: Your role (tappable buttons: Owner, Manager, Operations, Other)
Step 3: What do you manage? (tappable buttons: Rental Properties, Fleet Vehicles, Both, Other)
Step 4: How many assets? (tappable buttons: 1-10, 11-50, 50-100, 100+)
Step 5: Add your first property or vehicle (simplified form — type, name/address, basic info)
Step 6: Pricing — show ONLY business tiers:
  - Business Starter: $49.99/mo or $41.66/mo annual ($499.90/yr)
  - Business Pro: $119.99/mo or $99.99/mo annual ($1,199.90/yr)
  - Business Unlimited: $349.99/mo or $291.66/mo annual ($3,499.90/yr)
  - Annual toggle preselected
  - "Start Free Trial" buttons → Stripe checkout
  - "Continue with free trial" option at bottom

After completion: save company_name, business_role, business_type, business_onboarded=true to users table. Redirect to /dashboard.

### /dashboard (Business version)
- Detect business surface → render BusinessDashboard component
- Sidebar navigation: Dashboard, All Entries, Spending, Damage Reports, Settings
- "Switch to Personal" link → app.usetended.com
- Top metrics bar: Total Assets, Total Spend, Entries This Month, Avg Health Score
- Main content: sortable, filterable table of all assets
- Table columns: Name, Type, Health Score, Last Service, Next Due, Monthly Spend, Status
- Bulk actions: Export CSV, Generate Reports
- NO asset cards. Tables only.

### /dashboard/entries
- All maintenance entries across all assets in one table
- Filterable by date, asset, category, badge type, cost
- Export to CSV

### /dashboard/spending
- Placeholder for Build 3 — charts and analytics
- Show "Coming Soon — Spending analytics will be available here"

### /dashboard/damage
- All damage reports across all assets

### /dashboard/business-settings
- Company info, plan details, billing link

## PAGES — SHARED (work on both subdomains)
- /dashboard/asset/[id] — asset detail view
- /dashboard/asset/[id]/log — log entry page
- /help — FAQ page
- /dashboard/profile — My Account page

## PAGES — CONSUMER ONLY (app.usetended.com)
These should 404 or redirect on business.usetended.com:
- /build/* — Build Sheet
- /merch — Merch page
- /score — Vehicle score tool
- /onboarding (consumer onboarding)

## AUTH FLOW — BUSINESS

1. User visits business.usetended.com
2. Middleware detects business → serves business login
3. User signs up → Supabase creates account
4. Auth callback detects business surface → redirects to /onboarding/business
5. User completes business onboarding → data saved to users table
6. User sees business pricing → selects tier → Stripe checkout
7. Stripe webhook fires → updates tier to business_starter/pro/unlimited
8. User redirected to business dashboard

### Auth Callback (src/app/auth/callback/route.ts)
- Must check for surface=business parameter OR business hostname
- If business → redirect to /onboarding/business (if not onboarded) or /dashboard (if onboarded)
- If consumer → redirect to consumer onboarding or dashboard

### Supabase Auth Config
- Redirect URLs allowlist must include: https://business.usetended.com/**
- This is set in Supabase dashboard, not in code

## STRIPE — BUSINESS TIERS

Price IDs are in .env.local:
- NEXT_PUBLIC_STRIPE_PRICE_BUSINESS_STARTER_MONTHLY
- NEXT_PUBLIC_STRIPE_PRICE_BUSINESS_STARTER_ANNUAL
- NEXT_PUBLIC_STRIPE_PRICE_BUSINESS_PRO_MONTHLY
- NEXT_PUBLIC_STRIPE_PRICE_BUSINESS_PRO_ANNUAL
- NEXT_PUBLIC_STRIPE_PRICE_BUSINESS_UNLIMITED_MONTHLY
- NEXT_PUBLIC_STRIPE_PRICE_BUSINESS_UNLIMITED_ANNUAL

Tier limits:
- business_starter: 10 assets, 1 user
- business_pro: 50 assets, 3 users
- business_unlimited: unlimited assets, unlimited users

Business subscribers also get personal access at app.usetended.com with premium_pro features (5 personal assets).

## DATABASE — BUSINESS FIELDS

Table: users (public schema)
- company_name: TEXT
- business_role: TEXT (Owner, Manager, Operations, Other)
- business_type: TEXT (rental_properties, fleet_vehicles, both, other)
- business_onboarded: BOOLEAN DEFAULT FALSE

## DESIGN — BUSINESS

- Dark navy hero/header (#0D1626)
- White content areas
- DM Sans for ALL text (not Playfair Display)
- Professional, corporate feel — no playful colors
- Tables, not cards
- Sidebar navigation, not top tabs
- 44px minimum touch targets
- Mobile responsive — tables scroll horizontally

## TESTING REQUIREMENTS

Before reporting any business feature as done:
1. Visit business.usetended.com — does the business login show?
2. Click "Start Free Trial" — does signup work?
3. Complete business onboarding — does each step save data?
4. Does pricing show only business tiers?
5. Does Stripe checkout link work?
6. Does the business dashboard render with the table view?
7. Check on mobile (375px) — does everything fit?
8. Visit app.usetended.com — does it still show the consumer experience?
9. A business subscriber visiting app.usetended.com — do they get premium_pro access?
