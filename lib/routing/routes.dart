const RootRoute = "/overview";

const OverViewPageDisplayName = "Overview";
const OverViewPageRoute = "/overview";

const DriversPageDisplayName = "Betting Pools";
const DriversPageRoute = "/pools";

const ClientsPageDisplayName = "Clients";
const ClientsPageRoute = "/clients";

const AuthenticationPageDisplayName = "Log Out";
const AuthenticationPageRoute = "/auth";

class MenuItem{
  final String name;
  final String route;
  MenuItem(this.name, this.route);
}


List<MenuItem> sideMenuItems = [
  MenuItem(OverViewPageDisplayName, OverViewPageRoute),
  MenuItem(DriversPageDisplayName, DriversPageRoute),
  MenuItem(ClientsPageDisplayName, ClientsPageRoute),
  MenuItem(AuthenticationPageDisplayName, AuthenticationPageRoute),
];
// List sideMenuItems = [
//   OverViewPageRoute,
//   DriversPageRoute,
//   ClientsPageRoute,
//   AuthenticationPageRoute
// ];