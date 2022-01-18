<script>
  import {
    Header,
    HeaderUtilities,
    HeaderGlobalAction,
    HeaderActionLink,
    SideNav,
    SideNavLink,
    SideNavItems,
  } from 'carbon-components-svelte';
  import Sun20 from 'carbon-icons-svelte/lib/Sun20';
  import Moon20 from 'carbon-icons-svelte/lib/Moon20';
  import Home20 from 'carbon-icons-svelte/lib/Home20';

  export let theme;

  let isSideNavOpen = false;

  const changeTheme = () => {
    theme = theme == 'g10' ? 'g90' : 'g10';
  };
</script>

<Header company="AUISS" platformName="Admin" bind:isSideNavOpen>
  <HeaderUtilities>
    <HeaderActionLink href="/" icon={Home20} />
    <HeaderGlobalAction on:click={changeTheme} icon={Sun20} closeIcon={Moon20} />
  </HeaderUtilities>
</Header>

<SideNav bind:isOpen={isSideNavOpen}>
  <SideNavItems>
    <SideNavLink href="/admin" text="Home" />
    <SideNavLink href="/admin" text="Events" />
    <SideNavLink href="/admin/clubs" text="Clubs" />
    <SideNavLink href="/admin" text="Kedai" />
    <SideNavLink href="/admin/blog" text="Blog" />
    <SideNavLink href="/admin" text="About" />
    <SideNavLink href="/admin/contacts" text="Contacts" />
  </SideNavItems>
</SideNav>
