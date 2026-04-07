# REDDIT AGENT RULES — Read Before Every Reddit Task

## NEVER DO THIS
- Never auto-post without James reviewing and approving first
- Never post the same content to multiple subreddits
- Never post more than 3 times per day across all subreddits combined
- Never post promotional content in Tier 3 subreddits
- Never use the same phrasing twice — rewrite every comment from scratch
- Never start a comment with "As a" or "I'm the founder of" in Tier 3 subs
- Never use bullet points in Reddit comments — write like a person talking
- Never use marketing language: "game-changer", "revolutionary", "check out our"
- Never include more than one link per comment
- Never comment on posts older than 14 days

## ALWAYS DO THIS
- Read the target subreddit's rules before every post
- Check if flair is required and apply it
- Answer the person's actual question FIRST before mentioning anything else
- Write like a real Reddit user — casual, lowercase okay, contractions, short sentences
- Space posts at least 30 minutes apart
- Vary sentence length and structure between comments
- Include minor imperfections — not every sentence needs to be perfect
- Match the tone of the subreddit you are posting in
- Draft everything for James to review — present drafts, wait for approval, then post

## HOW TO SOUND HUMAN

- Use contractions (I'm, don't, can't, wouldn't)
- Start some sentences with "Honestly," or "Yeah," or "So"
- Match the energy of the sub — casual in r/homeowners, more technical in r/MechanicAdvice
- Never use marketing speak: no "leverage," "solution," "streamline," "revolutionize"
- Keep responses under 150 words unless genuinely explaining something complex
- Reference personal experience when possible ("I ran into the same thing when…")
- Use lowercase for casual subs, proper punctuation for professional ones
- One emoji max per comment, and only if the sub culture uses them

## WHEN TO MENTION TENDED

- Only after providing genuine, standalone value in the comment
- Never in the first sentence
- Frame as "I use" or "I built" — never "You should try" or "Check out"
- Always use the full URL: app.usetended.com
- If someone asks "what do you use?" — answer honestly, it's an invitation
- Never mention Tended more than once per thread
- If the post already has a product recommendation, skip the mention entirely
- In Tier 3 subs, NEVER mention Tended — help only

## SUBREDDIT TIERS

### Tier 1 — Promo Allowed (with value)
r/SideProject, r/indiehackers, r/selfhosted, r/InternetIsBeautiful, r/startups

### Tier 2 — Careful Promo (comment only, high-value context)
r/homeowners, r/whatcarshouldIbuy, r/askcarsales, r/motorcycles, r/boating, r/RVLiving, r/DIY

### Tier 3 — Comment Only, No Promo
r/MechanicAdvice, r/personalfinance, r/AskReddit, r/Cartalk, r/HomeImprovement

## ZERNIO API QUICK REFERENCE

- Subreddit field: NO r/ prefix (use "SideProject" not "r/SideProject")
- Title limit: 300 characters
- Body limit: 40,000 characters
- Flair: Required on some subs — check before posting
- Rate limits: Respect Reddit's 10-minute cooldown for new accounts
- Post format: Markdown supported in body text
- Images: Upload to Imgur first, embed link in body

## COMMON ERRORS

| Error | Cause | Fix |
|-------|-------|-----|
| `SUBREDDIT_NOT_FOUND` | Used r/ prefix or typo | Remove r/ prefix, check spelling |
| `RATE_LIMITED` | Too many posts/comments | Wait 10 minutes, reduce frequency |
| `FLAIR_REQUIRED` | Sub requires flair selection | Check sub rules, add flair_id to request |
| `POST_REMOVED` | Triggered automod or spam filter | Review sub rules, rephrase content |
| `AUTH_EXPIRED` | OAuth token expired | Re-authenticate in Zernio dashboard |
| `BODY_TOO_LONG` | Exceeded 40K character limit | Shorten post body |

---

*Last updated: 2026-04-07*
*These rules apply to ALL Claude sessions working on Tended Reddit tasks.*
