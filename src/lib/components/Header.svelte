<script>
  import {
    Header,
    HeaderNav,
    HeaderNavItem,
    HeaderUtilities,
    HeaderGlobalAction,
    HeaderAction,
    HeaderActionLink,
    HeaderPanelLink,
    SideNav,
    SideNavLink,
    SideNavItems,
  } from 'carbon-components-svelte';
  import Sun20 from 'carbon-icons-svelte/lib/Sun20';
  import Moon20 from 'carbon-icons-svelte/lib/Moon20';
  import UserAvatarFilledAlt20 from 'carbon-icons-svelte/lib/UserAvatarFilledAlt20';
  import SettingsAdjust20 from 'carbon-icons-svelte/lib/SettingsAdjust20';
  import { supabase } from '$lib/db';

  export let theme;
  export let authenticated;
  export let role;

  let isSideNavOpen = false;
  let isProfileOpen = false;

  const changeTheme = () => {
    theme = theme == 'g10' ? 'g90' : 'g10';
  };

  const signOut = async () => {
    authenticated = false;
    await supabase.auth.signOut();
  };
</script>

<Header company="AUISS" expandedByDefault={false} bind:isSideNavOpen>
  <HeaderNav>
    <HeaderNavItem href="/" text="Home" />
    <HeaderNavItem href="/events" text="Events" />
    <HeaderNavItem href="/clubs" text="Clubs" />
    <HeaderNavItem href="/kedai" text="Kedai" />
    <HeaderNavItem href="/blog" text="Blog" />
    <HeaderNavItem href="/about" text="About" />
    {#if !authenticated}
      <HeaderNavItem href="/signin" text="Sign In" />
    {/if}
  </HeaderNav>
  <HeaderUtilities>
    {#if role === 'admin'}
      <HeaderActionLink href="/admin" icon={SettingsAdjust20} />
    {/if}
    {#if authenticated}
      <HeaderAction bind:isOpen={isProfileOpen} icon={UserAvatarFilledAlt20}>
        <HeaderPanelLink href="/profile">Profile</HeaderPanelLink>
        <HeaderPanelLink href="/profile/clubs">You Clubs</HeaderPanelLink>
        <HeaderPanelLink on:click={signOut}>Sign Out</HeaderPanelLink>
      </HeaderAction>
    {/if}
    <HeaderGlobalAction on:click={changeTheme} icon={Sun20} closeIcon={Moon20} />
  </HeaderUtilities>
</Header>

<SideNav bind:isOpen={isSideNavOpen}>
  <SideNavItems>
    <SideNavLink href="/" text="Home" />
    <SideNavLink href="/events" text="Events" />
    <SideNavLink href="/clubs" text="Clubs" />
    <SideNavLink href="/kedai" text="Kedai" />
    <SideNavLink href="/blog" text="Blog" />
    <SideNavLink href="/about" text="About" />
    <SideNavLink href="/contact" text="Contact" />
    {#if !authenticated}
      <SideNavLink href="/signin" text="Sign In" />
    {/if}
  </SideNavItems>
</SideNav>
