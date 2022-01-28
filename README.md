# AUISS Web NodeJS Prototype

AUISS website clone in javascript with:

- [sveltekit](https://kit.svelte.dev/) (fullstack javascript framework)
- [carbon design system](https://www.carbondesignsystem.com/) (for quick ui)
- [supabase](https://supabase.io) (for authentication)

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

## Todo

- [x] dockerize app
- [ ] setup ci/cd
- [ ] deploy to digitalocean
- [x] add profile utility in header after login
- [x] add email validation for tp emails only
- [ ] self-host supabase (not on hold now, ditch supabase storage)
- [ ] setup docker-compose for app+supabase+smtp+nginx
- [ ] document database schema, policies, functions, triggers, etc (in progress)
- [x] add logic for student & alumni roles
- [x] add input validation for user profile update
- [x] add user_club table and func
- [x] add ui for user clubs
- [ ] fix posgres rls issue for select with auth.role() and auth.uid() (BUG)
- [x] add rls for club update (only allow admin)
- [x] add thumbnail update option with filepicker for club admin
- [x] create ui for blog post
- [x] add first blog post in markdown
- [ ] markdown img tag gets wrap by p getting indent. fix, hack, or ignore?
- [x] decide: keep unprotected images in supabase or in repo
- [x] add blog thumbnails
- [ ] add file upload functionality to server (NO IDEA)
- [ ] add pagination for blog posts (not working. might be bug???)
- [x] add contacts
- [x] add add row functionality for admin
- [x] decide: ssr or ssg for blog (whether to put content to db) (SSG)
- [x] add delete func for admin tables
- [ ] add links directly to contacts
- [x] add delete func to tags in blogs (admin)
- [ ] add func for users to join club
- [ ] ...
