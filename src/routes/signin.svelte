<script context="module">
  export const load = async ({ session }) => {
    const { user } = session;
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
    Grid,
  } from 'carbon-components-svelte';
  import ArrowRight16 from 'carbon-icons-svelte/lib/ArrowRight16';
  import { supabase } from '$lib/db';

  let loading = false;
  let email = '';
  let invalidInput = false;
  let status = 'active'; // active | inactive | finished | error
  let description = 'Signing in...'; // Signing In... | An Error Occured | Check Your Inbox

  const validateEmail = (email) => {
    return email.match('tp\\d{6}@mail\\.apu\\.edu\\.my');
  };

  const onSubmit = async (e) => {
    // validation
    const lower = email.toLowerCase();
    if (!validateEmail(lower)) {
      invalidInput = true;
      return;
    }

    loading = true;
    const { error } = await supabase.auth.signIn({
      email: lower,
    });
    if (error) console.log(error.message);
    status = error ? 'error' : 'finished';
    description = error ? 'An error occured' : 'Check your inbox';
  };
</script>

<div id="login-container">
  <Tile>
    <Grid padding noGutter>
      <Row>
        <Column>
          <h1>Sign In</h1>
        </Column>
      </Row>
      <Row>
        <Column>
          <Form on:submit={onSubmit}>
            <TextInput
              labelText="Email"
              placeholder="Enter your Email"
              invalidText="TP Email is Required"
              bind:invalid={invalidInput}
              bind:value={email}
              on:keydown={() => {
                invalidInput = false;
              }}
            />
            <div style="margin-top: 1.5rem">
              {#if !loading}
                <Button type="submit" style="text-align: right" icon={ArrowRight16}>Sign In</Button>
              {:else}
                <InlineLoading {status} {description} />
              {/if}
            </div>
          </Form>
        </Column>
      </Row>
    </Grid>
  </Tile>
</div>
