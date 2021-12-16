# AUISS Web NodeJS Prototype
AUISS website clone in javascript with:
- [sveltekit](https://kit.svelte.dev/) (fullstack javascript framework)
- [carbon design system](https://www.carbondesignsystem.com/) (for quick ui)
- [supabase](https://supabase.io) (for authentication)

## Todo
- [ ] dockerize app
- [ ] setup ci/cd
- [ ] deploy to digitalocean
- [ ] add profile utility in header after login
- [ ] setup database (local, not supabase (free tier only has 500mb storage))
- [ ] add other user functionalities
- [ ] add other admin functionalities
- [ ] ...

## Developing
Setup local project:
```bash
# setup
git clone https://github.com/rmrt1n/auiss-nodejs-prototype.git
cd auiss-nodejs-prototype
npm install

# run dev server
npm run dev

# to specify port
# npm run dev -- --port XXXX
```

You need to have a supabase project setup first. [Tutorial](https://supabase.com/docs).
After setup, copy the project url & anon key from the api setting. Rename the 
`.env.example` file to `.env` and update the contents with your credentials.
```bash
# change these
VITE_SUPABASE_URL=https://XXX.supabase.co
VITE_SUPABASE_ANON_KEY=XXX
```
