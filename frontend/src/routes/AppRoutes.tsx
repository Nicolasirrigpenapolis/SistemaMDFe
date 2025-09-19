import { Routes, Route } from 'react-router-dom';
import { Dashboard } from '../pages/Dashboard/Dashboard';
import { ListarMDFe } from '../pages/MDFe/ListarMDFe/ListarMDFe';
import { FormularioMDFe } from '../pages/MDFe/FormularioMDFe/FormularioMDFe';
import { ListarEmitentes } from '../pages/Emitentes/ListarEmitentes/ListarEmitentes';
import { ListarVeiculos } from '../pages/Veiculos/ListarVeiculos/ListarVeiculos';
import { ListarCondutores } from '../pages/Condutores/ListarCondutores/ListarCondutores';
import { ListarContratantes } from '../pages/Contratantes/ListarContratantes/ListarContratantes';
import { ListarSeguradoras } from '../pages/Seguradoras/ListarSeguradoras/ListarSeguradoras';
import { ListarMunicipios } from '../pages/Municipios/ListarMunicipios/ListarMunicipios';

export function AppRoutes() {
  return (
    <Routes>
      {/* Dashboard */}
      <Route path="/" element={<Dashboard />} />
      <Route path="/dashboard" element={<Dashboard />} />

      {/* MDFe */}
      <Route path="/mdfes" element={<ListarMDFe />} />
      <Route path="/mdfes/novo" element={<FormularioMDFe />} />
      <Route path="/mdfes/editar/:id" element={<FormularioMDFe />} />

      {/* Outras entidades - apenas listagem, CRUD via modal */}
      <Route path="/emitentes" element={<ListarEmitentes />} />
      <Route path="/veiculos" element={<ListarVeiculos />} />
      <Route path="/condutores" element={<ListarCondutores />} />
      <Route path="/contratantes" element={<ListarContratantes />} />
      <Route path="/seguradoras" element={<ListarSeguradoras />} />
      <Route path="/municipios" element={<ListarMunicipios />} />
    </Routes>
  );
}