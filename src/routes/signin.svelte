<script context="module">
  export const load = async ({ session }) => {
    const { user } = session;
    console.log('FUCK YOU', user);
    if (user && user.guest) return {};
    return {
      status: 302,
      redirect: '/profile',
    };
  };
</script>

<script>
  import {
    Tile,
    Form,
    TextInput,
    Button,
    Row,
    Column,
    InlineLoading,
  } from 'carbon-components-svelte';
  import ArrowRight16 from 'carbon-icons-svelte/lib/ArrowRight16';
  import { supabase } from '$lib/db';

  let loading = false;
  let email = null;
  let status = 'active'; // active | inactive | finished | error
  let desc = 'Signing In...';

  const onSubmit = async (e) => {
    loading = true;
    const { error } = await supabase.auth.signIn({
      email: email,
    });
    status = error ? 'error' : 'finished';
    desc = error ? 'An Error Occured' : 'Check Your Inbox';
  };
</script>

<div id="login-container">
  <Tile>
    <Row>
      <Column>
        <h1>Sign In</h1>
      </Column>
    </Row>
    <Row>
      <Column>
        <Form on:submit={onSubmit}>
          <TextInput
            style="margin-bottom: 1.5rem"
            labelText="Email"
            placeholder="Enter your Email"
            bind:value={email}
          />
          {#if !loading}
            <Button type="submit" style="text-align: right" icon={ArrowRight16}>Sign In</Button>
          {:else}
            <InlineLoading {status} description={desc} />
          {/if}
        </Form>
      </Column>
    </Row>
  </Tile>
</div>

<style>
  #login-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    min-height: calc(100vh - 6rem - 6rem);
  }

  h1 {
    margin-bottom: 1.5rem;
  }
</style>
