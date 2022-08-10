using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TDSAlmaxarifado.Models;

namespace TDSAlmaxarifado.Controllers
{
    public class ColaboradorController : Controller
    {
        BDTDSAlmaxarifadoEntities bd = new BDTDSAlmaxarifadoEntities();
        // GET: Colaborador
        public ActionResult Index()
        {
            return View(bd.Colaborador.ToList());
        }

        [HttpGet]
        public ActionResult Create()
        {
            ViewBag.listaArea = bd.AREA.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult Create(string nome,string cargo,int? codigoarea)
        {
            Colaborador colaborador = new Colaborador();
            colaborador.colnome = nome;
            colaborador.colcargo = cargo;
            colaborador.Areid = codigoarea;

            bd.Colaborador.Add(colaborador);
            bd.SaveChanges();
            try
            {
              
            }
            catch (Exception)
            {
                return RedirectToAction("ErrorBD", "Home");
            }

            return RedirectToAction("index");
        }
    }
}