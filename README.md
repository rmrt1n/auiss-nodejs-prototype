# AUISS Web NodeJS Prototype

AUISS website clone in javascript with:

- [sveltekit](https://kit.svelte.dev/) (fullstack javascript framework)
- [carbon design system](https://www.carbondesignsystem.com/) (for quick ui)
- [supabase](https://supabase.io) (for authentication)

## Todo

- [x] dockerize app
- [ ] setup ci/cd
- [ ] deploy to digitalocean
- [x] add profile utility in header after login
- [ ] add other user functionalities
- [ ] add other admin functionalities
- [x] add email validation for tp emails only
- [ ] self-host supabase (on hold now because supabase studio doesn't support storage atm)
- [ ] setup docker-compose for app+supabase+smtp+nginx
- [ ] document database schema, policies, functions, triggers, etc
- [ ] add logic for student & alumni roles
- [x] add input validation for user profile update
- [ ] add user_club table and func
- [ ] ...

## Developing

Setup local project:

```bash
# setup
git clone https://github.com/rmrt1n/auiss-nodejs-prototype.git
cd auiss-nodejs-prototype
npm install
npm prepare # install husky hooks

# run dev server
npm run dev

# to specify port
npm run dev -- --port XXXX

# docker development
docker build . -t <img name> --target base
# running
docker run --rm -it \     # removes container after finished & interactive mode
  -v $PWD:/app \          # mounts local files to container
  -v /app/node_modules \  # ignores local node_modules
  -p 3000:3000            # exposes container port 3000 to local port 3000
  <img name> \
  npm run dev -- --host   # command to run

# docker production build
docker build . -t <img name> \
  --build-arg supabase_url=<your supabase url>
  --build-arg supabase_anon_key=<your supabase anon key>
# running
docker run -p 3000:3000 <img name>
```

You need to have a supabase project setup first. [Tutorial](https://supabase.com/docs).
After setup, copy the project url & anon key from the api setting. Rename the
`.env.example` file to `.env` and update the contents with your credentials.

```bash
# change these
VITE_SUPABASE_URL=https://XXX.supabase.co
VITE_SUPABASE_ANON_KEY=XXX
```
