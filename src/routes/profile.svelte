<script context="module">
  export const load = async ({ session }) => {
    const { user } = session;
    if (user && !user.guest) return { props: { user: user } };
    return {
      status: 302,
      redirect: '/signin',
    };
  };
</script>

<script>
  export let user;
</script>

<h1>Profile</h1>
<div style="white-space: pre-wrap">
  {JSON.stringify(user, null, 2)}
</div>
